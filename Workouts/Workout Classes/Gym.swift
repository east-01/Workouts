//
//  Gym.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/5/23.
//

import Foundation

class Gym: Codable, Equatable {
    var name: String
    var equipment: [Equipment]
    var exerciseBlacklist: [Exercise]
    init(name: String, equipment: [Equipment], exerciseBlacklist: [Exercise]) {
        self.name = name
        self.equipment = equipment
        self.exerciseBlacklist = exerciseBlacklist
    }
    func addToBlacklist(exercise: Exercise) {
        if(exerciseBlacklist.firstIndex(of: exercise) != nil) { return }
        exerciseBlacklist.append(exercise)
    }
    func canPerformExercise(exercise: Exercise) -> Bool {
        return self.equipment.contains(exercise.data().equipment) && !self.exerciseBlacklist.contains(exercise)
    }
    static func == (lhs: Gym, rhs: Gym) -> Bool {
        return lhs.name == rhs.name && lhs.equipment == rhs.equipment && lhs.exerciseBlacklist == rhs.exerciseBlacklist
    }
}

func getDefaultGyms() -> [Gym] {
    return [
        Gym(name: "Bodyweight only", equipment: [.NONE, .BODYWEIGHT], exerciseBlacklist: []),
        Gym(name: "Home gym", equipment: [.NONE, .BODYWEIGHT, .DUMBBELLS, .BARBELL, .BENCH, .INCLINE_BENCH, .DECLINE_BENCH, .LONG_BAND, .PULL_UP_BAR], exerciseBlacklist: []),
        Gym(name: "Commercial gym", equipment: Equipment.allCases, exerciseBlacklist: [])
    ]
}
