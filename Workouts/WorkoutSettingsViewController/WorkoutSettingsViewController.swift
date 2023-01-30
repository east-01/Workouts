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
    
    @IBOutlet weak var gymView: UIView!
    @IBOutlet weak var gymPicker: UIPickerView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    // If this number exists, this means that we're editing the schedule menu NOT creating a workout
    var scheduleIndex: Int?
    var currentSettings: WorkoutSettings?
    private var isValid: Bool = false
    
    private var gyms: [Gym] = []
    private var muscleSelections: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        titleView.layer.cornerRadius = 12
        settingsView.layer.cornerRadius = 12
        muscleView.layer.cornerRadius = 12
        
        muscleGroupScrollView.layer.cornerRadius = 8
                
        submitButton.layer.cornerRadius = 12
        
        createMuscleGroupButtons()
        
        if(currentSettings == nil) {
            // Load default settings
            currentSettings = WorkoutSettings(
                name: "Generated on \(getDateString())",
                muscleGroups: [],
                gym: getProfile().gyms[0],
                exerciseCount: 12,
                prefersSupersets: true,
                groupExercisesByMuscle: false
            )
        }
        
        loadGymView()
        
        // Show whatever is in the current settings to sync up if we've come from a schedule or from scratch
        showSettings()
        // Save those settings to check validity
        saveSettings()
        
    }
    
    @IBAction func submitted(_ sender: Any) {
        
        saveSettings()
        
        if(!isValid) {
            return
        }
        
        // If schedule index doesn't exist this means we're creating a workout
        if(scheduleIndex == nil) {
            currentWorkout = Workout(settings: currentSettings!);
            // TODO Be careful of overwriting existing workout, maybe add a dialogue to warn about this
            saveCurrentWorkout()
            performSegue(withIdentifier: "workoutSettingsToWorkoutView", sender: self)
        } else { // If it exists it means we're editing schedule settings
            setScheduleSettings(dayOfWeek: scheduleIndex!, settings: currentSettings!)
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
            button.setTitle(muscle.getDisplayName(), for: .normal)
            button.setTitleColor(UIColor(named: "ForegroundColor"), for: .normal)
            button.addTarget(self, action: #selector(muscleGroupClicked), for: .touchUpInside)
            // Add tag and boolean value for selection list
            button.tag = i
            muscleSelections.append(false)
            // Add to stack
            muscleGroupStack.addArrangedSubview(button)

        }
        
    }
    
    // This function makes sure that the all the visual parts of the ViewController
    //   reflect what's in the current settings, not the other way around
    // We are responsible for changing the values in currentSettings elsewhere
    func showSettings() {
        
        guard let settings = currentSettings else {
            return
        }
            
        let generalGroups = Muscle.getGeneralGroups()
        for i in 0...generalGroups.count-1 {
            var isSelectedInSettings: Bool = false
            // Check if the current muscle group is already set in the settings, change the selection value to reflect this
            for testMuscle in settings.muscleGroups {
                if(testMuscle == generalGroups[i]) {
                    isSelectedInSettings = true
                    break
                }
            }
            muscleSelections[i] = isSelectedInSettings
            muscleGroupStack.arrangedSubviews[i].backgroundColor = muscleSelections[i] ? UIColor(named: "AccentColor") : UIColor(named: "BackgroundColor")
        }
        
        exerciseStepper.value = Double(settings.exerciseCount)
        exerciseCountText.text = "\(settings.exerciseCount)"

        supersetsToggle.isOn = settings.prefersSupersets
        groupToggle.isOn = settings.groupExercisesByMuscle
                
        gymPicker.selectRow(getProfile().gyms.firstIndex(of: settings.gym)!, inComponent: 0, animated: true)
        
    }
    
    // This function makes sure that all of the settings currently represnted
    //   on screen are saved in currentSettings
    func saveSettings() {
                        
        var isValid = true
        
        let generalGroups = Muscle.getGeneralGroups()
        var muscleGroups: [Muscle] = []
        for i in 0...muscleSelections.count-1 {
            if(muscleSelections[i]) {
                muscleGroups.append(generalGroups[i])
            }
        }
        if(muscleGroups.count == 0) {
            isValid = false
        }
        
        let gymSelection = gymPicker.selectedRow(inComponent: 0)
        if(gymSelection < 0 || gymSelection > getProfile().gyms.count-1) {
            isValid = false
        }
        
        let exerciseCount = Int(exerciseStepper.value)
        exerciseCountText.text = "\(currentSettings!.exerciseCount)"

        let prefersSupersets = supersetsToggle.isOn
        let groupByMuscle = groupToggle.isOn

        self.isValid = isValid
        
        // Update button to reflect changes
        UIView.animate(withDuration: 0.2, animations: {
            self.submitButton.backgroundColor = UIColor(named: isValid ? "AccentColor" : "BackgroundAccentColor")
        })
        
        if(!isValid) {
            return
        }

        currentSettings = WorkoutSettings(
            name: "Generated on \(getDateString())",
            muscleGroups: muscleGroups,
            gym: getProfile().gyms[gymSelection],
            exerciseCount: exerciseCount,
            prefersSupersets: prefersSupersets,
            groupExercisesByMuscle: groupByMuscle
        )
                
    }
    
    @IBAction func clickedCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func muscleGroupClicked(_ sender: UIButton) {
        muscleSelections[sender.tag] = !muscleSelections[sender.tag]
        saveSettings()
        sender.backgroundColor = muscleSelections[sender.tag] ? UIColor(named: "AccentColor") : UIColor(named: "BackgroundColor")
    }

    @IBAction func exerciseCountChanged(_ sender: UIStepper) {
        if(exerciseStepper.value <= 0) {
            sender.value = 1
        }
        saveSettings()
    }
     
    @IBAction func toggleClicked(_ sender: UISwitch) {
        saveSettings()
    }
    
    private func getDateString() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yy"
        return format.string(from: date)
    }
    
}
