//
//  SwapExerciseViewManager.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/15/23.
//

import Foundation
import UIKit

extension ExerciseDetailsViewController {

    func loadSwapExerciseView() {
        
        settingsOverlay = OverlayView(superview: self.view)
        settingsOverlay!.createCenterView(insets: UIEdgeInsets(top: 280, left: 30, bottom: -280, right: -30))
        settingsOverlay!.isHidden = true
        
        guard let centerView = settingsOverlay!.centerView else {
            return
        }
        
        centerView.layer.borderWidth = 2.5
        centerView.layer.borderColor = UIColor(named: "BackgroundAccentColor2")!.cgColor
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Swap Exercise"
        titleLabel.textColor = UIColor(named: "ForegroundColor")
        titleLabel.font = .boldSystemFont(ofSize: 25)
        
        let confirmButton = UIButton()
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.backgroundColor = UIColor(named: "AccentColor")
        confirmButton.layer.cornerRadius = 8
        confirmButton.setTitle("Swap", for: .normal)
        confirmButton.setTitleColor(UIColor(named: "ForegroundColor"), for: .normal)
        confirmButton.addTarget(self, action: #selector(clickedSwap), for: .touchUpInside)
        
        let checkboxStackHeight = ExerciseDetailsViewController.checkboxOptions.count*40 + (ExerciseDetailsViewController.checkboxOptions.count-1)*10
        checkboxStack = UIStackView()
        checkboxStack!.translatesAutoresizingMaskIntoConstraints = false
        checkboxStack!.spacing = 10
        checkboxStack!.axis = .vertical
        checkboxStack!.distribution = .fillEqually
        
        for i in 0...ExerciseDetailsViewController.checkboxOptions.count-1 {
            let checkBox: CheckBoxWithText = CheckBoxWithText(text: ExerciseDetailsViewController.checkboxOptions[i])
            checkBox.tag = i
            checkBox.textLabel.font = .systemFont(ofSize: 20)
            checkBox.textLabel.adjustsFontSizeToFitWidth = true
            checkboxStack!.addArrangedSubview(checkBox)
        }
                
        centerView.addSubview(checkboxStack!)
        centerView.addSubview(titleLabel)
        centerView.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: centerView.topAnchor, constant: 15),
            
            confirmButton.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 15),
            confirmButton.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -15),
            confirmButton.bottomAnchor.constraint(equalTo: centerView.bottomAnchor, constant: -15),
            confirmButton.heightAnchor.constraint(equalToConstant: 55),
            
            checkboxStack!.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 15),
            checkboxStack!.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -15),
            checkboxStack!.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            checkboxStack!.heightAnchor.constraint(equalToConstant: CGFloat(checkboxStackHeight))
        ])
        
    }

    @IBAction func clickedSettings(_ sender: Any) {
        settingsOverlay!.show()
    }
        
    @objc func clickedSwap(_ sender: UIButton) {
        
        guard let exercise = exercise else {
            print("ERROR: Exercise optional nil when making a swap. This is illegal.")
            return
        }
        guard var currentProfile = currentProfile else {
            print("ERROR: Failed to get the current profile when executing a swap.")
            return
        }
        if(currentProfile.exerciseWeights[exercise] == nil) {
            print("ERROR: Exercise weights doesn't contain exercise \(String(describing: exercise)), swap failed")
            return
        }

        // "Can't do this exercise at this gym" is selected
        if((checkboxStack!.arrangedSubviews[0] as! CheckBoxWithText).getState()) {
            let gym = currentWorkout!.getSettings().gym
            let gyms = getProfile().gyms
            if(gyms.firstIndex(of: gym) != nil) {
                gyms[gyms.firstIndex(of: gym)!].addToBlacklist(exercise: exercise)
            }
        }
        
        // "I don't like it" is selected
        if((checkboxStack!.arrangedSubviews[1] as! CheckBoxWithText).getState()) {
            // TODO: How much should selecting this reduce weight by?
            currentProfile.exerciseWeights[exercise]! -= 2
            if(currentProfile.exerciseWeights[exercise])! < 0 {
                currentProfile.exerciseWeights[exercise]! = 0
            }
        }

        // "It doesn't fit in this workout" is selected
        if((checkboxStack!.arrangedSubviews[2] as! CheckBoxWithText).getState()) {
            // TODO: How should we treat this? We'll need to look at what the other exercises are in the workout, calculate based off of that. Good luck.
            print("TODO: Unfinished \"doesn't fit in this workout\" selection in swap exercises.")
        }
        
        currentWorkout!.swap(exercise)
        saveCurrentWorkout()
        
        settingsOverlay!.hide()
        dismiss(animated: true)
        
        saveProfile()
        
    }
    
}
