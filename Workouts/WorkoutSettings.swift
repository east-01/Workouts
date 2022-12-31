//
//  WorkoutSettings.swift
//  Workouts
//
//  Created by Ethan Mullen on 12/31/22.
//

import Foundation

struct WorkoutSettings: Codable {
    var name: String
    var muscleGroups: [Muscle]
    var exerciseCount: Int
    var prefersSupersets: Bool
    var groupExercisesByMuscle: Bool
}
