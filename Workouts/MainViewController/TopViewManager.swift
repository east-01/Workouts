//
//  TopViewManager.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/4/23.
//

import Foundation
import UIKit

/**
 Top view manager
 Responsible for the top view on the main screen. Currently only shows a greeting and the users name
 */
extension MainViewController {
    
    func loadTopView() {
        
        topView.layer.cornerRadius = 12
        
        // Manage top view
        updateGreetingText()        
        
    }
    
    func updateGreetingText() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        var greeting = "Welcome back, "
        if(hour > 19 || hour < 2) {
            greeting = "Good evening, "
        } else if(hour >= 2 && hour < 10) {
            greeting = "Good morning, "
        }
        greetingText.text = "\(greeting)\(getProfile().username)"
    }
    
}
