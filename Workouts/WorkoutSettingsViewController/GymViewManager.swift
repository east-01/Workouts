//
//  GymViewManager.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/5/23.
//

import Foundation
import UIKit

extension WorkoutSettingsViewController {
    
    func loadGymView() {
        
        gymView.layer.cornerRadius = 12
        
        gymPicker.dataSource = self
        gymPicker.delegate = self
        gymPicker.setValue(UIColor(named: "ForegroundColor"), forKeyPath: "textColor")
        
    }
    
}

extension WorkoutSettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return getGyms().count
    }
}

extension WorkoutSettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: getGyms()[row].name, attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "ForegroundColor")!])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        saveSettings()
    }
}
