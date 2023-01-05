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
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var newWorkoutButton: UIButton!
    @IBOutlet weak var newWorkoutButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var newWorkoutButtonHeight: NSLayoutConstraint!
    var newWorkoutView: NewWorkoutView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        topView.layer.cornerRadius = 12
        
        loadTopView()
        
        if(currentWorkout == nil) {
            currentWorkout = loadCurrentWorkout()
        }
        
        // Manage current workout view
        loadCurrentWorkoutView()

        // Manage schedule view
        scheduleView.layer.cornerRadius = 12
        updateScheduleView()
        
        loadNewWorkoutView()
                
    }
        
    override func viewWillAppear(_ animated: Bool) {
        updateScheduleView()
    }
                                
}

