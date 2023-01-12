//
//  Gym.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/5/23.
//

import Foundation

struct Gym: Codable, Equatable {
    var name: String
    var equipment: [Equipment]
    var exerciseBlacklist: [Exercise]
}

private var gyms: [Gym]?

func getDefaultGyms() -> [Gym] {
    return [
        Gym(name: "Bodyweight only", equipment: [.NONE, .BODYWEIGHT], exerciseBlacklist: []),
        Gym(name: "Home gym", equipment: [.NONE, .BODYWEIGHT, .DUMBBELLS, .BARBELL, .BENCH, .INCLINE_BENCH, .DECLINE_BENCH, .LONG_BAND, .PULL_UP_BAR], exerciseBlacklist: []),
        Gym(name: "Commercial gym", equipment: Equipment.allCases, exerciseBlacklist: [])
    ]
}
