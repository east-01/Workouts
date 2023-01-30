//
//  SetSubCell.swift
//  Workouts
//
//  Created by Ethan Mullen on 12/28/22.
//

import UIKit

class SetSubCell: UIView {
    
    var exerciseUnit: ExerciseUnit
    
    var nameText: UILabel
    var setrepText: UILabel
    
    init(exerciseUnit: ExerciseUnit) {
        self.exerciseUnit = exerciseUnit
        self.nameText = UILabel()
        self.setrepText = UILabel()
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "BackgroundAccentColor2")
        self.layer.cornerRadius = 8        
        self.isUserInteractionEnabled = true
        
        nameText = createTextLabel(text: exerciseUnit.exercise.data().displayName, isBold: false, fontSize: 35)
        nameText.adjustsFontSizeToFitWidth = true
        self.addSubview(nameText)

        setrepText = createTextLabel(text: exerciseUnit.createRepString(), isBold: true, fontSize: 35)
        setrepText.textAlignment = .right
        self.addSubview(setrepText)
                
        NSLayoutConstraint.activate([
            nameText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(SetCell.SUBCELL_INTERIOR_PADDING)),
            nameText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(-SetCell.SUBCELL_INTERIOR_PADDING)),
            nameText.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(SetCell.SUBCELL_INTERIOR_PADDING)),

            setrepText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(SetCell.SUBCELL_INTERIOR_PADDING)),
            setrepText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(-SetCell.SUBCELL_INTERIOR_PADDING))
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
