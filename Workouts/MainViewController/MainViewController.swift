//
//  ViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/23/22.
//

import UIKit

// Main view controller is broken into several components, organized by their height on the main view:
// - TopViewManager: manages the greeting text and handles the profile button for now
// - CurrentWorkoutViewManager: Manages the current workout view, handles whether it appears or not
// - ScheduleManager: Manages the schedule view and schedule buttons
// - NewWorkoutViewManager: Manages the new workout view that pops up when you tap on the plus button
class MainViewController: UIViewController {
    
    var userName: String = "User"
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var greetingText: UILabel!
    
    var currentWorkoutView: UIView?
    var currentWorkoutViewText: UILabel?
    
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var scheduleStack: UIStackView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var newWorkoutButton: UIButton!
    @IBOutlet weak var newWorkoutButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var newWorkoutButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var newWorkoutButtonBottomConstraint: NSLayoutConstraint!
    
    var newWorkoutView: NewWorkoutView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(currentWorkout == nil) {
            currentWorkout = loadCurrentWorkout()
        }

        // Manage top view
        loadTopView()
                
        // Manage current workout view
        loadCurrentWorkoutView()

        // Manage schedule view
        scheduleView.layer.cornerRadius = 12
        updateScheduleView()
        
        // Manage new workout view
        loadNewWorkoutView()
                
    }
        
    override func viewWillAppear(_ animated: Bool) {
        updateScheduleView()
    }
                                
}

