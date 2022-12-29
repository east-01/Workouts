//
//  SetSubCell.swift
//  Workouts
//
//  Created by Ethan Mullen on 12/28/22.
//

import UIKit

class SetSubCell: UIView {
    
    var setCell: SetCell
    var exercise: Exercise
    var sets: Int
    var reps: Int
    
    init(setCell: SetCell, exercise: Exercise, sets: Int, reps: Int) {
        self.setCell = setCell
        self.exercise = exercise
        self.sets = sets
        self.reps = reps
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
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        gestureRecognizer.direction = .left
        gestureRecognizer.numberOfTouchesRequired = 1
        
        self.addGestureRecognizer(gestureRecognizer)
        
        let nameText = createTextLabel(text: exercise.data().displayName, isBold: false, fontSize: 35)
        nameText.adjustsFontSizeToFitWidth = true
        setCell.nameTexts.append(nameText)
        self.addSubview(nameText)

        let setrepText = createTextLabel(text: "\(sets) x \(reps)", isBold: true, fontSize: 35)
        setrepText.textAlignment = .right
        setCell.setrepTexts.append(setrepText)
        self.addSubview(setrepText)
                
        NSLayoutConstraint.activate([
            nameText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(SetCell.SUBCELL_INTERIOR_PADDING)),
            nameText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(-SetCell.SUBCELL_INTERIOR_PADDING)),
            nameText.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(SetCell.SUBCELL_INTERIOR_PADDING)),

            setrepText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(SetCell.SUBCELL_INTERIOR_PADDING)),
            setrepText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(-SetCell.SUBCELL_INTERIOR_PADDING))
        ])

    }
    
    @objc func swiped(_ sender: UISwipeGestureRecognizer) {
        if(sender.state == .ended) {
            sender.view?.backgroundColor = .systemGreen
        }
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
