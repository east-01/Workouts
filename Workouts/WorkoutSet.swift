//
//  Set.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/23/22.
//

import Foundation

class WorkoutSet {
    
    var exercises: [Exercise]
    var sets: [Int]
    var reps: [Int]
    
    var isSuperset: Bool
    
    // Non-superset constructor
    init(exercise: Exercise, sets: Int, reps: Int) {
        self.exercises = Array(arrayLiteral: exercise)
        self.sets = Array(arrayLiteral: sets)
        self.reps = Array(arrayLiteral: reps)
        self.isSuperset = false
    }
    
    // Superset constructor
    init(exercises: [Exercise], sets: [Int], reps: [Int]) {
        self.exercises = exercises
        self.sets = sets
        self.reps = reps
        self.isSuperset = exercises.count > 1 ? true : false
    }
    
}
