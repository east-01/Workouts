//
//  Workout.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/23/22.
//

import Foundation

var currentWorkout: Workout?

func loadCurrentWorkout() -> Workout? {
    if let data = UserDefaults.standard.data(forKey: "CurrentWorkout") {
        if let decoded = try? JSONDecoder().decode(Workout.self, from: data) {
            return decoded
        }
    }
    return nil
}

func saveCurrentWorkout() {
    if let encoded = try? JSONEncoder().encode(currentWorkout) {
        UserDefaults.standard.set(encoded, forKey: "CurrentWorkout")
    }
}

class Workout: Codable {
    
    var sets: [WorkoutSet]
    var name: String
    var muscleGroups: [Muscle]
    
    var settings: WorkoutSettings
        
    init(settings: WorkoutSettings) {
        self.name = settings.name
        self.sets = []
        self.muscleGroups = settings.muscleGroups
        self.settings = settings
        generateWorkout()
    }
    
    func completedSetsAmount() -> Int {
        var cnt: Int = 0
        for workoutSet in sets {
            if(workoutSet.isComplete) {
                cnt += 1
            }
        }
        return cnt
    }
    
    func progress() -> Float {
        if(sets.count == 0) {
            return 0
        }
        return Float(completedSetsAmount()) / Float(sets.count)
    }
    
    func muscleListString() -> String {
        if(muscleGroups.isEmpty) {
            return ""
        }
        var string = ""
        for i in 0...muscleGroups.count-1 {
            if(i != 0) {
                string += ", "
            }
            string += muscleGroups[i].getDisplayName()
        }
        return string
    }
    
    func getSettings() -> WorkoutSettings {
        return settings
    }
    
}

enum WorkoutType {
    case SET_REP; case ABS;
    func getDisplayName() -> String {
        switch self {
        case .SET_REP:
            return "Multi-set"
        case .ABS:
            return "Abs"
        }
    }
}
