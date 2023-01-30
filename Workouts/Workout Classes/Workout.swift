//
//  Workout.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/23/22.
//

import Foundation

var currentWorkout: Workout?

func loadCurrentWorkout() -> Workout? {
    if let data = UserDefaults.standard.data(forKey: "CurrentWorkout") {
        if let decoded = try? JSONDecoder().decode(Workout.self, from: data) {
            return decoded
        }
    }
    return nil
}

func saveCurrentWorkout() {
    if let encoded = try? JSONEncoder().encode(currentWorkout) {
        UserDefaults.standard.set(encoded, forKey: "CurrentWorkout")
    }
}

class Workout: Codable {
    
    var sets: [WorkoutSet]
    var name: String
    var muscleGroups: [Muscle]
    
    private var settings: WorkoutSettings
        
    init(settings: WorkoutSettings) {
        self.name = settings.name
        self.sets = []
        self.muscleGroups = settings.muscleGroups
        self.settings = settings
        generateWorkout()
    }
    
    func generateWorkout() {
        
        print("Generating a workout with groups: \(muscleGroups)")
        
        var prefersSupersets = settings.prefersSupersets
        if(settings.muscleGroups.count == 1) {
            prefersSupersets = false
        }
        
        let exercisesPerMuscleGroup = settings.exerciseCount / muscleGroups.count
                
        // Sort and grap exercise options for each muscle group
        var groupAndOptions: [Muscle : [Exercise]] = [:]
        for muscleGroup in muscleGroups {
            var options: [Exercise] = []
            for exercise in Exercise.allCases {
                // Make sure that we can use this exercise in this gym
                if(!settings.gym.canPerformExercise(exercise: exercise)) { continue }
                // Sort find all of the existing exercises that have this general group as the primary group
                let firstMuscle = exercise.data().muscleGroups[0]
                if(firstMuscle == muscleGroup || firstMuscle.getGeneralGroup() == muscleGroup) {
                    options.append(exercise)
                }
            }
            // Shuffle the options and add them to the map
            options.shuffle()
            groupAndOptions.updateValue(Array(options.prefix(exercisesPerMuscleGroup)), forKey: muscleGroup)
        }
        
        var exercises: [Exercise] = []
        // Markers that show when to close out a superset and start a new one
        var supersetMarkers: [Int] = []
        
        // Shuffle the exercises to be in desired order
        if(settings.groupExercisesByMuscle) {
            var totalCount: Int = 0
            for muscle in muscleGroups {
                let exercisesByMuscle = groupAndOptions[muscle]!
                exercises.append(contentsOf: exercisesByMuscle)
                totalCount += exercisesByMuscle.count
                supersetMarkers.append(totalCount-1)
            }
        } else {
            var totalCount: Int = 0
            for i in 0...exercisesPerMuscleGroup {
                for muscle in muscleGroups {
                    if(i >= groupAndOptions[muscle]!.count) {
                        continue
                    }
                    exercises.append(groupAndOptions[muscle]![i])
                    totalCount += 1
                }
                supersetMarkers.append(totalCount-1)
            }
        }

        var exerciseUnits: [ExerciseUnit] = []
        // Store set count here so we have continuity inside supersets
        var sets: Int? = nil
        for i in 0..<exercises.count {
            let exercise = exercises[i]
            
            // Pick new set count based off of current superset
            if(sets == nil) {
                sets = 4
            }
            
            // Pick these each time based off of exercise
            let baseRepCount = 10
            let dynamicSetIncrement = Bool.random() ? 2 : 0
            
            var reps: [Int] = []
            for a in 0..<sets! {
                reps.append(baseRepCount + (dynamicSetIncrement * a))
            }
            
            let exerciseUnit = ExerciseUnit(exercise: exercise, reps: reps)
            exerciseUnits.append(exerciseUnit)
            
            let reset_superset = !prefersSupersets || supersetMarkers.contains(i) || (i+1) >= exercises.count
            if(reset_superset) {
                self.sets.append(WorkoutSet(exerciseUnits: exerciseUnits))
                exerciseUnits = []
                sets = nil
            }
            
        }
        
    }
    
    // Swap out the current exercise for an equal one
    func swap(_ exercise: Exercise) {
        let newExercise: Exercise = .ASSISTED_PULL_UPS
        let newExerciseUnit: ExerciseUnit = ExerciseUnit(exercise: newExercise, reps: [12, 12, 14])
        
        // Find the exercise
        for setNum in 0...sets.count-1 {
            let set: WorkoutSet = sets[setNum]
            for exNum in 0...set.exerciseUnits.count-1 {
                if(set.exerciseUnits[exNum].exercise == exercise) {
                    
                    // Found exercise, swap it out for the new one
                    set.exerciseUnits[exNum] = newExerciseUnit
                    
                }
            }
        }
        
        print("Swapping out \(exercise) for \(newExercise)")
    }
    
    func completedSetsAmount() -> Int {
        var cnt: Int = 0
        for workoutSet in sets {
            if(workoutSet.isComplete) {
                cnt += 1
            }
        }
        return cnt
    }
    
    func progress() -> Float {
        return Float(completedSetsAmount()) / Float(sets.count)
    }
    
    func muscleListString() -> String {
        if(muscleGroups.isEmpty) {
            return ""
        }
        var string = ""
        for i in 0...muscleGroups.count-1 {
            if(i != 0) {
                string += ", "
            }
            string += muscleGroups[i].getDisplayName()
        }
        return string
    }
    
    func getSettings() -> WorkoutSettings {
        return settings
    }
    
}
