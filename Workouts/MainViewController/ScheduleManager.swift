//
//  ScheduleManager.swift
//  Workouts
//
//  Created by Ethan Mullen on 12/31/22.
//

import Foundation

private var scheduleSettings: [WorkoutSettings?]?

func getScheduleSettings() -> [WorkoutSettings?] {
    if(scheduleSettings == nil) { loadScheduleSettings() }
    return scheduleSettings!
}

func setScheduleSettings(dayOfWeek: Int, settings: WorkoutSettings) {
    if(scheduleSettings == nil) { loadScheduleSettings() }
    scheduleSettings![dayOfWeek] = settings
    saveScheduleSettings()
}

func clearScheduleSettings(dayOfWeek: Int) {
    if(scheduleSettings == nil) { loadScheduleSettings() }
    scheduleSettings![dayOfWeek] = nil
    saveScheduleSettings()
}

func loadScheduleSettings() {
    if let data = UserDefaults.standard.data(forKey: "ScheduleWorkoutSettings") {
        if let decoded = try? JSONDecoder().decode([WorkoutSettings?].self, from: data) {
            scheduleSettings = decoded
            return
        }
    }
    
    scheduleSettings = []
    for _ in 0...6 {
        scheduleSettings?.append(nil)
    }
}

func saveScheduleSettings() {
    if let encoded = try? JSONEncoder().encode(scheduleSettings) {
        UserDefaults.standard.set(encoded, forKey: "ScheduleWorkoutSettings")
    }
}
