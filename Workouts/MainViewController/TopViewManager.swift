//
//  TopViewManager.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/4/23.
//

import Foundation
import UIKit

extension MainViewController {
    
    func loadTopView() {
        
        // Load user profile
        if let data = UserDefaults.standard.data(forKey: "UserName") {
            if let decoded = try? JSONDecoder().decode(String.self, from: data) {
                userName = decoded
            }
        }
        
        // Manage top view
        updateGreetingText()

        let circleCount = 3
        
        NSLayoutConstraint.activate([
            topStack.widthAnchor.constraint(equalToConstant: CGFloat(110*circleCount + 5*(circleCount - 1)))
        ])
        
        // Load progress circles
        let progCircle: ProgressCircle = ProgressCircle(progress: 0.6, color: UIColor(named:"AccentColor")!, text: "Workouts Completed")
        progCircle.translatesAutoresizingMaskIntoConstraints = false
        progCircle.textLabel.textColor = UIColor(named: "ForegroundColor")
        let progCircle2: ProgressCircle = ProgressCircle(progress: 0.25, color: UIColor.systemCyan, text: "Goals Met")
        progCircle2.translatesAutoresizingMaskIntoConstraints = false
        progCircle2.textLabel.textColor = UIColor(named: "ForegroundColor")
        let progCircle3: ProgressCircle = ProgressCircle(progress: 0.95, color: UIColor.orange, text: "Challenge days left")
        progCircle3.translatesAutoresizingMaskIntoConstraints = false
        progCircle3.textLabel.textColor = UIColor(named: "ForegroundColor")

        topStack.addArrangedSubview(progCircle)
        topStack.addArrangedSubview(progCircle2)
        topStack.addArrangedSubview(progCircle3)
        
        
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
        greetingText.text = "\(greeting)\(userName)"
    }

    @IBAction func profileClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Edit profile", message: "Enter name", preferredStyle: .alert)
        alert.addTextField { (textField) in }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            // Save user data
            if let inputtedText = textField.text {
                if let encoded = try? JSONEncoder().encode(inputtedText) {
                    UserDefaults.standard.set(encoded, forKey: "UserName")
                    self.userName = inputtedText
                    self.updateGreetingText()
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
