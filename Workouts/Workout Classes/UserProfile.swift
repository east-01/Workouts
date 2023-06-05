//
//  UserProfile.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/7/23.
//

import Foundation

struct UserProfile: Codable {
    var username: String
    var gyms: [Gym]
    var exerciseWeights: [Exercise : Int]
    var workoutHistory: [Workout]
}

var currentProfile: UserProfile?

func getProfile() -> UserProfile {
    loadProfile()
    if(currentProfile == nil) {
        // Return a default profile
        return UserProfile(
            username: "User",
            gyms: getDefaultGyms(),
            exerciseWeights: generateDefaultExerciseWeights(),
            workoutHistory: []
        )
    }
    return currentProfile!
}

func loadProfile() {    
    if let data = UserDefaults.standard.data(forKey: "UserProfile") {
        if let decoded = try? JSONDecoder().decode(UserProfile.self, from: data) {
            currentProfile = decoded
        }
    }
}

func saveProfile() {
    guard let currentProfile = currentProfile else { return }
    if let encoded = try? JSONEncoder().encode(currentProfile) {
        UserDefaults.standard.set(encoded, forKey: "UserProfile")
    }
}

func setProfile(profile: UserProfile) {
    currentProfile = profile
    saveProfile()
}

func generateDefaultExerciseWeights() -> [Exercise : Int] {
    var weightMap: [Exercise : Int] = [:]
    for exercise in Exercise.allCases {
        let exerciseData = exercise.data()
        // Calculate exercise weight
        var weight = 10
        
        let isExclusivelyBodyweight = exerciseData.equipment.count == 1 && (exerciseData.equipment[0] == .NONE || exerciseData.equipment[0] == .BODYWEIGHT)
        if(!isExclusivelyBodyweight) {
            weight += 5
        }

        weightMap[exercise] = weight
    }
    return weightMap
}
