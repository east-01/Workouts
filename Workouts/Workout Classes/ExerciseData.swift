//
//  ExerciseData.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/5/23.
//

import Foundation

class ExerciseData {
    var displayName: String
    var muscleGroups: [Muscle]
    var equipment: [Equipment]
    init(_ dispName: String) {
        self.displayName = dispName
        self.muscleGroups = []
        self.equipment = []
    }
    func setMuscleGroups(_ g: [Muscle]) -> ExerciseData {
        self.muscleGroups = g
        return self
    }
    func setEquipment(_ e: [Equipment]) -> ExerciseData {
        self.equipment = e
        return self
    }
}
