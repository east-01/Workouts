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
    var gym: Gym
    var exerciseCount: Int
    var prefersSupersets: Bool
    var groupExercisesByMuscle: Bool
    func printSettings() {
        print("Exercise settings:")
        print("  Name: \(name)")
        print("  Groups: \(muscleGroups)")
        print("  Gym: \(gym.name)")
        print("  Exercise count: \(exerciseCount)")
        print("  Prefers supersets: \(prefersSupersets)")
        print("  Group by muscle: \(groupExercisesByMuscle)")
    }
}
