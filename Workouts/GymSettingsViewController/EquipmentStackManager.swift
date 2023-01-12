//
//  EquipmentStackManager.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/11/23.
//

import Foundation
import UIKit

extension GymSettingsViewController {
    
    func loadStack() {
        
        // Clear stack
        for subV in equipmentStack.arrangedSubviews {
            subV.removeFromSuperview()
        }
        
        // Resize stack height
        let count = equipmentSelected ? Equipment.allCases.count : gym.exerciseBlacklist.count
        if(count == 0) { return }
        
        equipmentStackHeight.constant = CGFloat(
            count*GymSettingsViewController.EXERCISE_STACK_BUTTON_HEIGHT + (count-1)*GymSettingsViewController.EXERCISE_STACK_SPACING
        )

        // Load equipment buttons or blacklist labels depending on which is selected in tab
        if(equipmentSelected) {
            for i in 0...Equipment.allCases.count-1 {
                let button = createStackButton(text: String(describing: Equipment.allCases[i]), tag: i)
                equipmentStack.addArrangedSubview(button)
                let showActive: Bool = gym.equipment.contains(Equipment.allCases[i])
                equipmentSelections.append(showActive)
            }
        } else {
            for blacklistedExercise in gym.exerciseBlacklist {
                equipmentStack.addArrangedSubview(createStackLabel(text: blacklistedExercise.data().displayName))
            }
        }

        showStack()
        
    }
    
    func showStack() {
        
        if(equipmentSelected) {
            for i in 0...Equipment.allCases.count-1 {
                let showActive: Bool = gym.equipment.contains(Equipment.allCases[i])
                equipmentSelections[i] = showActive
                equipmentStack.arrangedSubviews[i].backgroundColor = UIColor(named: showActive ? "AccentColor" : "BackgroundAccentColor2")
            }
        }
        
    }
    
    @discardableResult
    func saveStack() -> Bool {
        
        if(equipmentSelected) {
            var selectedEquipment: [Equipment] = []
            for i in 0...Equipment.allCases.count-1 {
                if(equipmentSelections[i]) {
                    selectedEquipment.append(Equipment.allCases[i])
                }
            }
            if(selectedEquipment.count == 0) {
                return false
            }
            gym.equipment = selectedEquipment
        } else {
            var exerciseBlacklist: [Exercise] = []
            for subview in equipmentStack.subviews {
                if(!(subview is UILabel)) { continue }
                let text = (subview as! UILabel).text!
                for testExercise in Exercise.allCases {
                    if(testExercise.data().displayName == text) {
                        exerciseBlacklist.append(testExercise)
                    }
                }
            }
            gym.exerciseBlacklist = exerciseBlacklist
        }
        
        
        return true
        
    }
    
    @objc func tappedStackButton(_ sender: UIButton) {
        equipmentSelections[sender.tag] = !equipmentSelections[sender.tag]
        saveSettings()
        sender.backgroundColor = UIColor(named: equipmentSelections[sender.tag] ? "AccentColor" : "BackgroundAccentColor2")
    }
    
    @objc func removeBlacklistedExerciseTapped(_ sender: UILongPressGestureRecognizer) {
        sender.view!.removeFromSuperview()
    }
    
    // Equipment button tag = 0, Blacklist button tag = 1
    @IBAction func tabButtonClicked(_ sender: UIButton) {
        let newSelectedVal = sender.tag == 0
        if(equipmentSelected == newSelectedVal) { return } // We don't need to change anything if we're tapping the already selected button
        saveStack() // Save the data in the current stack before we load the new one
        equipmentSelected = newSelectedVal
        equipmentButton.backgroundColor = UIColor(named: equipmentSelected ? "AccentColor" : "BackgroundColor")
        blacklistButton.backgroundColor = UIColor(named: !equipmentSelected ? "AccentColor" : "BackgroundColor")
        loadStack()
    }

    private func createStackButton(text: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.tag = tag
        button.addTarget(self, action: #selector(tappedStackButton), for: .touchUpInside)
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor(named: "ForegroundColor"), for: .normal)
        button.backgroundColor = UIColor(named: "BackgroundAccentColor2")
        button.layer.cornerRadius = 8
        return button
    }
    
    private func createStackLabel(text: String) -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "AccentColor")
        label.textColor = UIColor(named: "ForegroundColor")
        label.text = text
        label.layer.cornerRadius = 8
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(removeBlacklistedExerciseTapped))
        longPressRecognizer.numberOfTapsRequired = 0
        longPressRecognizer.numberOfTouchesRequired = 1
        longPressRecognizer.minimumPressDuration = 1
        label.addGestureRecognizer(longPressRecognizer)
        return label
    }
        
}
