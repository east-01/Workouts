//
//  Workout.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/23/22.
//

import Foundation

var currentWorkout: Workout?

class Workout {
    
    var sets: [WorkoutSet]
    var name: String
    
    init() {
        // Load the workouts here
        self.name = "Test"
        sets = []
//        for i in 0...0 {
//            sets.append(WorkoutSet(name: "deads \(i)", reps: 2))
//        }
        
        // Test workout
//        sets.append(WorkoutSet(exercises: [.DEADLIFT, .DB_HAMMER_CURLS], sets: [5, 5], reps: [8, 12]))
//        sets.append(WorkoutSet(exercise: .SHRUGS, sets: 4, reps: 12))
//        sets.append(WorkoutSet(exercise: .DB_DECLINE_BENCH, sets: 5, reps: 10))
//        sets.append(WorkoutSet(exercise: .LATERAL_RAISES, sets: 3, reps: 8))
//        sets.append(WorkoutSet(exercise: .BAR_CURLS, sets: 4, reps: 10))
//        sets.append(WorkoutSet(exercises: [.BB_BENCH, .BAR_CURLS, .LATERAL_RAISES], sets: [3, 3, 3], reps: [5, 5, 8]))

    }
    
    init(name: String, muscleGroups: [Muscle], exerciseCount: Int, prefersSupersets: Bool, groupExercisesByMuscle: Bool) {
        self.name = name
        self.sets = []
                
        let exercisesPerMuscleGroup = exerciseCount / muscleGroups.count
                
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
        if(groupExercisesByMuscle) {
            for muscle in groupAndOptions.keys {
                exercises.append(contentsOf: groupAndOptions[muscle]!)
            }
        } else {
            for i in 0...exercisesPerMuscleGroup {
                for muscle in groupAndOptions.keys {
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
                if(groupExercisesByMuscle) {
                    let currExerciseGroup = exercises[i].data().muscleGroups[0].getGeneralGroup()
                    let nextExerciseGroup = exercises[i+1].data().muscleGroups[0].getGeneralGroup()
                    // We know to reset when the exercises are grouped by muscle if the next element's
                    //   group doesn't equal the current elements group
                    reset = nextExerciseGroup != currExerciseGroup
                } else {
                    // We know to reset when the exercises are NOT grouped by muscle if the current element's
                    //   group is the same as the first group given in array
                    reset = i != 0 && exercises[i+1].data().muscleGroups[0].getGeneralGroup() == muscleGroups[0].getGeneralGroup()
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
    
}
