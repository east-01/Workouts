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
            // Sort find all of the existing exercises that have this general group as the primary group
            for exercise in Exercise.allCases {
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
        
        // Shuffle the exercises to be in order
        if(settings.groupExercisesByMuscle) {
            for muscle in muscleGroups {
                exercises.append(contentsOf: groupAndOptions[muscle]!)
            }
        } else {
            for i in 0...exercisesPerMuscleGroup {
                for muscle in muscleGroups {
                    if(i >= groupAndOptions[muscle]!.count) {
                        continue
                    }
                    exercises.append(groupAndOptions[muscle]![i])
                }
            }
        }
                        
        let setCount = 3
        let repCount = 10
                
        if(!prefersSupersets) {
            // Generate single-exercise sets
            for exercise in exercises {
                self.sets.append(WorkoutSet(exercise: exercise, sets: setCount, reps: repCount))
            }
        } else {
            // Generate supersets
            var superset_exercises: [Exercise] = []
            var superset_sets: [Int] = []
            var superset_reps: [Int] = []
            for i in 0..<exercises.count {
                superset_exercises.append(exercises[i])
                superset_sets.append(setCount)
                superset_reps.append(repCount)
                // Make sure we're not at the end of the array for reset-checking
                if(i+1 >= exercises.count) {
                    continue
                }
                // Check to see if we need to switch to a superset
                var reset: Bool = false
                if(settings.groupExercisesByMuscle) {
                    let currExerciseGroup = exercises[i].data().muscleGroups[0].getGeneralGroup()
                    let nextExerciseGroup = exercises[i+1].data().muscleGroups[0].getGeneralGroup()
                    // We know to reset when the exercises are grouped by muscle if the next element's
                    //   group doesn't equal the current elements group
                    reset = nextExerciseGroup != currExerciseGroup
                } else {
                    // We know to reset when the exercises are NOT grouped by muscle if the next element's
                    //   group position in muscleGroups is less than or equal to the current groups position
                    //   When we go backwards in position count this means a reset in the cycle
                    let currExerciseGroup = exercises[i].data().muscleGroups[0].getGeneralGroup()
                    let nextExerciseGroup = exercises[i+1].data().muscleGroups[0].getGeneralGroup()
                    reset = i != 0 && muscleGroups.firstIndex(of: nextExerciseGroup)! <= muscleGroups.firstIndex(of: currExerciseGroup)!
                }
                if(reset) {
                    self.sets.append(WorkoutSet(exercises: superset_exercises, sets: superset_sets, reps: superset_reps))
                    superset_exercises = []
                    superset_sets = []
                    superset_reps = []
                }
            }
            // Need to append one last WorkoutSet to add all of the data from the last loop
            self.sets.append(WorkoutSet(exercises: superset_exercises, sets: superset_sets, reps: superset_reps))
        }
                
    }
    
    // Swap out the current exercise for an equal one
    func swap(_ exercise: Exercise) {
        let newExercise: Exercise = .ASSISTED_PULL_UPS
        
        // Find the exercise
        for setNum in 0...sets.count-1 {
            let set: WorkoutSet = sets[setNum]
            for exNum in 0...set.exercises.count-1 {
                if(set.exercises[exNum] == exercise) {
                    
                    // Found exercise, swap it out for the new one
                    set.exercises[exNum] = newExercise
                    // TODO: Replace set/rep counts accordingly
                    set.sets[exNum] = 4
                    set.reps[exNum] = 12
                    
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
