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
    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var greetingText: UILabel!
    
    var currentWorkoutView: UIView?
    var currentWorkoutViewText: UILabel?
    
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var scheduleStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        topView.layer.cornerRadius = 12
        
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
        
        if(currentWorkout == nil) {
            currentWorkout = loadCurrentWorkout()
        }
        
        // Manage current workout view
        loadCurrentWorkoutView()

        // Manage schedule view
        scheduleView.layer.cornerRadius = 12
        updateScheduleView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        updateScheduleView()
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
        
    func loadCurrentWorkoutView() {
        
        if(currentWorkout == nil) {
            if(currentWorkoutView != nil) {
                currentWorkoutView!.removeFromSuperview()
                currentWorkoutView = nil
            }
            NSLayoutConstraint.activate([
                scheduleView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 15)
            ])
            return
        }
        
        if(currentWorkoutView == nil) {
            currentWorkoutView = UIView()
            currentWorkoutView!.translatesAutoresizingMaskIntoConstraints = false
            currentWorkoutView!.backgroundColor = UIColor(named: "BackgroundAccentColor")
            currentWorkoutView!.layer.cornerRadius = 12
            view.addSubview(currentWorkoutView!)
            
            currentWorkoutViewText = UILabel()
            currentWorkoutViewText!.translatesAutoresizingMaskIntoConstraints = false
            currentWorkoutViewText!.text = "Current workout:"
            currentWorkoutViewText!.textColor = UIColor(named: "ForegroundColor")
            currentWorkoutViewText!.font = .systemFont(ofSize: 20)
            currentWorkoutView!.addSubview(currentWorkoutViewText!)
                        
            NSLayoutConstraint.activate([
                currentWorkoutView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                currentWorkoutView!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                currentWorkoutView!.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 15),
                currentWorkoutView!.heightAnchor.constraint(equalToConstant: 135),
                
                currentWorkoutViewText!.leadingAnchor.constraint(equalTo: currentWorkoutView!.leadingAnchor, constant: 10),
                currentWorkoutViewText!.topAnchor.constraint(equalTo: currentWorkoutView!.topAnchor, constant: 10),
            
                scheduleView.topAnchor.constraint(equalTo: currentWorkoutView!.bottomAnchor, constant: 15)

            ])
            
        }
        
        let currentWorkoutTile = WorkoutTile(workout: currentWorkout!)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedCurrentWorkout))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        currentWorkoutTile.addGestureRecognizer(tapGesture)
        currentWorkoutView!.addSubview(currentWorkoutTile)
        
        NSLayoutConstraint.activate([
            currentWorkoutTile.leadingAnchor.constraint(equalTo: currentWorkoutView!.leadingAnchor, constant: 10),
            currentWorkoutTile.trailingAnchor.constraint(equalTo: currentWorkoutView!.trailingAnchor, constant: -10),
            currentWorkoutTile.topAnchor.constraint(equalTo: currentWorkoutViewText!.bottomAnchor, constant: 10),
            currentWorkoutTile.bottomAnchor.constraint(equalTo: currentWorkoutView!.bottomAnchor, constant: -10)
        ])
            
    }
    
    func updateScheduleView() {
                
        let workoutSchedule = getScheduleSettings()
        let dayOfWeek: Int = Calendar.current.dateComponents([.weekday], from: Date()).weekday! - 1
        for i in 0...scheduleStack.arrangedSubviews.count-1 {
            let uiview: UIView = scheduleStack.arrangedSubviews[i]
            uiview.tag = i
            // Add corner radius and border
            uiview.layer.masksToBounds = true
            uiview.layer.cornerRadius = 6
            if(dayOfWeek == i) {
                (uiview as! UILabel).layer.borderColor = UIColor(named: "AccentColor")!.cgColor
                (uiview as! UILabel).layer.borderWidth = 3
            }
            // Add tapping functionality
            if(uiview.gestureRecognizers == nil || uiview.gestureRecognizers!.isEmpty) {
                uiview.isUserInteractionEnabled = true
                let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedScheduleView))
                tapRecognizer.numberOfTapsRequired = 1
                tapRecognizer.numberOfTouchesRequired = 1
                uiview.addGestureRecognizer(tapRecognizer)
                let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressedScheduleView))
                longPressRecognizer.numberOfTapsRequired = 0
                longPressRecognizer.numberOfTouchesRequired = 1
                longPressRecognizer.minimumPressDuration = 1
                uiview.addGestureRecognizer(longPressRecognizer)
            }
            // TODO: Add tint for corresponding workout type
            if(workoutSchedule[i] != nil) {
                uiview.backgroundColor = UIColor(named: "AccentColorTint")
            } else {
                uiview.backgroundColor = UIColor(named: "BackgroundAccentColor2")
            }
        }

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
    
    @objc func tappedCurrentWorkout(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toWorkoutView", sender: self)
    }
    
    @objc func tappedScheduleView(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toWorkoutSettingsView", sender: sender.view!)
    }
    
    @objc func longPressedScheduleView(_ sender: UILongPressGestureRecognizer) {
        if(sender.state != .began) { return }
        if(getScheduleSettings()[sender.view!.tag] == nil) { return }
        let day = Calendar.current.weekdaySymbols[sender.view!.tag]
        let alert = UIAlertController(title: "Delete settings", message: "Are you sure you want to delete \(day)'s settings?", preferredStyle: .alert)
        alert.view.tintColor = UIColor(named: "AccentColor")
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            clearScheduleSettings(dayOfWeek: sender.view!.tag)
            self.updateScheduleView()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toWorkoutSettingsView") {
            let workoutSettingsViewController = segue.destination as! WorkoutSettingsViewController
            if(sender is UILabel) {
                workoutSettingsViewController.scheduleIndex = (sender as! UILabel).tag
                workoutSettingsViewController.currentSettings = getScheduleSettings()[(sender as! UILabel).tag]
            }
        }
    }
    
}

