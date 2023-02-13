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
        printSettings("")
    }
    func printSettings(_ prefix: String) {
        print("\(prefix)Workout settings:")
        print("\(prefix)  Name: \(name)")
        print("\(prefix)  Groups: \(muscleGroups)")
        print("\(prefix)  Gym: \(gym.name)")
        print("\(prefix)  Exercise count: \(exerciseCount)")
        print("\(prefix)  Prefers supersets: \(prefersSupersets)")
        print("\(prefix)  Group by muscle: \(groupExercisesByMuscle)")
    }
}
