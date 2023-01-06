//
//  Gym.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/5/23.
//

import Foundation

struct Gym: Codable {
    var name: String
    var equipment: [Equipment]
}

private var gyms: [Gym]?

func getGyms() -> [Gym] {
    if(gyms == nil) { loadGyms() }
    return gyms!
}

func loadGyms() {
    if let data = UserDefaults.standard.data(forKey: "Gyms") {
        if let decoded = try? JSONDecoder().decode([Gym].self, from: data) {
            gyms = decoded
            return
        }
    }
    
    if(gyms == nil) {
        // Load default gyms
        gyms = [
            Gym(name: "Bodyweight only", equipment: [.NONE, .BODYWEIGHT]),
            Gym(name: "Home gym", equipment: [.NONE, .BODYWEIGHT, .DUMBBELLS, .BARBELL, .BENCH, .INCLINE_BENCH, .DECLINE_BENCH, .LONG_BAND, .PULL_UP_BAR]),
            Gym(name: "Commercial gym", equipment: Equipment.allCases)
        ]
    }
}

func saveGyms() {
    if let encoded = try? JSONEncoder().encode(gyms) {
        UserDefaults.standard.set(encoded, forKey: "Gyms")
    }
}
