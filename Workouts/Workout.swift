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
        sets.append(WorkoutSet(exercises: [.DEADLIFT, .DB_HAMMER_CURLS], sets: [5, 5], reps: [8, 12]))
        sets.append(WorkoutSet(exercise: .SHRUGS, sets: 4, reps: 12))
        sets.append(WorkoutSet(exercise: .DB_DECLINE_BENCH, sets: 5, reps: 10))
        sets.append(WorkoutSet(exercise: .LATERAL_RAISES, sets: 3, reps: 8))
        sets.append(WorkoutSet(exercise: .BAR_CURLS, sets: 4, reps: 10))
        sets.append(WorkoutSet(exercises: [.BB_BENCH, .BAR_CURLS, .LATERAL_RAISES], sets: [3, 3, 3], reps: [5, 5, 8]))

    }
    
    init(name: String, muscleGroups: [Muscle], exerciseCount: Int, prefersSupersets: Bool, groupExercisesByMuscle: Bool) {
        self.name = name
        self.sets = []
        
        var exercisesPerMuscleGroup = exerciseCount % muscleGroups.count
        
        for muscleGroup in muscleGroups {
            
        }
        
        
    }
    
}
