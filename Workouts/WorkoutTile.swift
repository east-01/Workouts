//
//  WorkoutTile.swift
//  Workouts
//
//  Created by Ethan Mullen on 12/29/22.
//

import UIKit

class WorkoutTile: UIView {

    var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
     
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "BackgroundAccentColor2")
        self.layer.cornerRadius = 12
        
        let titleLabel = createTextLabel(text: workout.name, isBold: true, fontSize: 30)
        titleLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(titleLabel)
        
        let muscleGroupsLabel = createTextLabel(text: workout.muscleListString(), isBold: false, fontSize: 20)
        muscleGroupsLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(muscleGroupsLabel)
                
        let completionLabelText = String(Int(round(workout.progress() * 100))) + "%"
        let completionLabel = createTextLabel(text: completionLabelText, isBold: false, fontSize: 30)
        completionLabel.textAlignment = .right
        self.addSubview(completionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: completionLabel.leadingAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            muscleGroupsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            muscleGroupsLabel.trailingAnchor.constraint(equalTo: completionLabel.leadingAnchor, constant: -5),
            muscleGroupsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

            completionLabel.widthAnchor.constraint(equalToConstant: 70),
            completionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            completionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    private func createTextLabel(text: String, isBold: Bool, fontSize: Float) -> UILabel {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = isBold ? .boldSystemFont(ofSize: CGFloat(fontSize)) : .systemFont(ofSize: CGFloat(fontSize))
        label.textColor = UIColor(named: "ForegroundColor")
        return label
    }

}
