//
//  CurrentWorkoutViewManager.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/4/23.
//

import Foundation
import UIKit

/**
 Current workout view manager
 Responsible for showing the current workout (if there is one), will add a new UIView and add proper constraints to show the workout
 */
extension MainViewController {
    
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

    @objc func tappedCurrentWorkout(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toWorkoutView", sender: self)
    }

}
