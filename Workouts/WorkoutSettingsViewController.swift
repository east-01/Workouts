//
//  WorkoutSettingsViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 12/19/22.
//

import UIKit

class WorkoutSettingsViewController: UIViewController {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var muscleView: UIView!
        
    @IBOutlet weak var muscleGroupScrollView: UIScrollView!
    @IBOutlet weak var muscleGroupStack: UIStackView!
    @IBOutlet weak var muscleGroupStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var exerciseStepper: UIStepper!
    @IBOutlet weak var exerciseCountText: UILabel!
    
    @IBOutlet weak var supersetsToggle: UISwitch!
    @IBOutlet weak var groupToggle: UISwitch!
    
    // If this number exists, this means that we're editing the schedule menu NOT creating a workout
    var scheduleIndex: Int?
    
    private var exerciseCount: Int = 12
    
    private var muscleSelections: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        titleView.layer.cornerRadius = 12
        settingsView.layer.cornerRadius = 12
        muscleView.layer.cornerRadius = 12
        
        muscleGroupScrollView.layer.cornerRadius = 8
                
        createMuscleGroupButtons()
        
        // TODO: Load previous settings/default values here
        exerciseStepper.value = 12
        supersetsToggle.isOn = true
        groupToggle.isOn = false
        
    }
    
    @IBAction func submitted(_ sender: Any) {
        // Generate default title
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yy"
        let dateString = format.string(from: date)
        
        // Figure out which muscle groups are selected from the button list
        let muscleGroupsKey = Muscle.getGeneralGroups()
        var muscleGroups: [Muscle] = []
        for i in 0...muscleSelections.count-1 {
            if(muscleSelections[i]) {
                muscleGroups.append(muscleGroupsKey[i])
            }
        }
                
        let settings = WorkoutSettings(
            name: "Generated on \(dateString)",
            muscleGroups: muscleGroups,
            exerciseCount: self.exerciseCount,
            prefersSupersets: supersetsToggle.isOn,
            groupExercisesByMuscle: groupToggle.isOn
        )
        
        // If schedule index doesn't exist this means we're creating a workout
        if(scheduleIndex == nil) {
            currentWorkout = Workout(settings: settings);
            // TODO Be careful of overwriting existing workout, maybe add a dialogue to warn about this
            saveCurrentWorkout()
            performSegue(withIdentifier: "workoutSettingsToWorkoutView", sender: self)
        } else { // If it exists it means we're editing schedule settings
            setScheduleSettings(dayOfWeek: scheduleIndex!, settings: settings)
            scheduleIndex = nil
            dismiss(animated: true)
        }
        
    }
                   
    func createMuscleGroupButtons() {
        let buttonHeight = 45
        let generalGroups = Muscle.getGeneralGroups()
        muscleGroupStackHeight.constant = CGFloat(generalGroups.count * buttonHeight + (generalGroups.count - 1) * Int(muscleGroupStack.spacing))
        
        for i in 0...generalGroups.count-1 {
            let muscle = generalGroups[i]
            // Create button
            let button: UIButton = UIButton()
            button.backgroundColor = UIColor(named: "BackgroundColor")
            button.layer.cornerRadius = 8
            button.setTitle(String(describing: muscle), for: .normal)
            button.setTitleColor(UIColor(named: "ForegroundColor"), for: .normal)
            button.addTarget(self, action: #selector(muscleGroupClicked), for: .touchUpInside)
            // Add tag and boolean value for selection list
            button.tag = i
            muscleSelections.append(false)
            // Add to stack
            muscleGroupStack.addArrangedSubview(button)

        }
        
    }
    
    @objc func muscleGroupClicked(_ sender: UIButton) {
        muscleSelections[sender.tag] = !muscleSelections[sender.tag]
        sender.backgroundColor = muscleSelections[sender.tag] ? UIColor(named: "AccentColor") : UIColor(named: "BackgroundColor")
    }

    @IBAction func exerciseCountChanged(_ sender: Any) {
        exerciseCount = Int(exerciseStepper.value)
        exerciseCountText.text = "\(exerciseCount)"
    }
    
}
