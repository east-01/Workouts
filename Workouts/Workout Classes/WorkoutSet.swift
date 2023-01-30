//
//  Set.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/23/22.
//

import Foundation

class WorkoutSet: Codable {
    
    var exerciseUnits: [ExerciseUnit]
    var isSuperset: Bool
    var isComplete: Bool
    
    // Non-superset constructor
    init(exerciseUnit: ExerciseUnit) {
        self.exerciseUnits = [exerciseUnit]
        self.isSuperset = false
        self.isComplete = false
    }
    
    // Superset constructor
    init(exerciseUnits: [ExerciseUnit]) {
        self.exerciseUnits = exerciseUnits
        self.isSuperset = exerciseUnits.count > 1 ? true : false
        self.isComplete = false
    }
    
}

struct ExerciseUnit: Codable {
    var exercise: Exercise
    var reps: [Int]
    
    func createRepString() -> String {
        var allSame = true
        for i in 0...reps.count-1 {
            if(reps[i] != reps[0]) {
                allSame = false
                break
            }
        }
        if(allSame) {
            return "\(reps.count) x \(reps[0])"
        } else {
            var returnString = ""
            for i in 0...reps.count-1 {
                if(i != 0) {
                    returnString += " | "
                }
                returnString += String(reps[i])
            }
            return returnString
        }
    }
}
