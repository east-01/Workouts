//
//  ViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/23/22.
//

import UIKit

class MainViewController: UIViewController {
    
    var userName: String = "User"
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var greetingText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.layer.cornerRadius = 12
        
        // Load user profile
        if let data = UserDefaults.standard.data(forKey: "UserName") {
            if let decoded = try? JSONDecoder().decode(String.self, from: data) {
                userName = decoded
            }
        }
        
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
        greetingText.text = "\(greeting)\(userName)"
    }
    
    @IBAction func newWorkoutClicked(_ sender: Any) {
        currentWorkout = Workout();
    }
    
    @IBAction func profileClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Edit profile", message: "Enter name", preferredStyle: .alert)

        alert.addTextField { (textField) in
            
        }

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

