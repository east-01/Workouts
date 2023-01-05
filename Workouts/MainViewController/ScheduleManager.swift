//
//  ScheduleManager.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/2/23.
//

import Foundation
import UIKit

extension MainViewController {
    
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
