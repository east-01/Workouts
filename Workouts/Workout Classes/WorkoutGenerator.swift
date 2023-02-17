//
//  WorkoutGenerator.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/30/23.
//

import Foundation

extension Workout {
    
    func generateWorkout() {
                
        var prefersSupersets = settings.prefersSupersets
        if(settings.muscleGroups.count == 1) {
            prefersSupersets = false
        }
        
        let exercisesPerMuscleGroup = settings.exerciseCount / muscleGroups.count
                
        // Sort and grap exercise options for each muscle group
        var groupAndOptions: [Muscle : [Exercise]] = [:]
        self.exercisesByGroup = [:]
        
        var elimsByMuscle: [Muscle : Int] = [:] // We want to store the amount of eliminations for diagnostics later
        
        for muscleGroup in muscleGroups {
            let options: WeightedList<Exercise> = WeightedList<Exercise>()
            var elims: Int = 0
            for exercise in Exercise.allCases {
                // Sort find all of the existing exercises that have this general group as the primary group
                let firstMuscle = exercise.data().muscleGroups[0]
                let isValidExercise = firstMuscle == muscleGroup || firstMuscle.getGeneralGroup() == muscleGroup
                
                if(!isValidExercise) { continue }
                // Make sure that we can use this exercise in this gym
                if(!settings.gym.canPerformExercise(exercise: exercise)) {
                    elims += 1
                    continue
                }

                let exerciseData = exercise.data()
                // Calculate exercise weight
                var weight = 10
                
                let isExclusivelyBodyweight = exerciseData.equipment.count == 1 && (exerciseData.equipment[0] == .NONE || exerciseData.equipment[0] == .BODYWEIGHT)
                if(!isExclusivelyBodyweight) {
                    weight += 5
                }
                
                options.addItem(exercise, weight: weight)
                
            }
            
            // Pick choices from the options weighted list
            var optionsList: [Exercise] = []
            for _ in 0 ..< exercisesPerMuscleGroup {
                let choice = options.random(removeChoice: true)
                if(choice != nil) {
                    optionsList.append(choice!)
                }
            }
            
            exercisesByGroup.updateValue(options, forKey: muscleGroup)
            groupAndOptions.updateValue(optionsList, forKey: muscleGroup)
            elimsByMuscle.updateValue(elims, forKey: muscleGroup)
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
        var dynamicSetIncrement: Int = 0
        for i in 0..<exercises.count {
            let exercise = exercises[i]
            
            // Pick new set count based off of current superset
            if(sets == nil) {
                sets = Int.random(in: 3...5)
                dynamicSetIncrement = Bool.random() && sets! < 5 ? 2 : 0
            }
            
            // Pick these each time based off of exercise
            let baseRepCount = -2*sets! + 18
            
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
        
        let printStats = true;
        
        if(printStats) {
            print("Generated new workout:")
            settings.printSettings()
            print("  Gym exercise blacklist: \(settings.gym.exerciseBlacklist)")
            print("Result: ")
            print("  Groups: \(muscleGroups)")
            print("  ExercisesPerGroup: \(exercisesPerMuscleGroup)")
            print("  Size of each option list:")
            for musc in groupAndOptions.keys {
                print("    \(musc), \(groupAndOptions[musc]!.count); elims: \(elimsByMuscle[musc]!)")
            }
            print("  Ended up making \(self.sets.count) set(s).")
            
        }
        
    }
    
    // Swap out the current exercise for an equal one
    func swap(_ exercise: Exercise) {
        
        guard let newExercise: Exercise = exercisesByGroup[exercise.data().muscleGroups[0].getGeneralGroup()]!.random(removeChoice: true) else {
            return
        }
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
    
    func canSwap(_ exercise: Exercise) -> Bool {
        return exercisesByGroup[exercise.data().muscleGroups[0].getGeneralGroup()]!.count() > 1
    }
    
}
