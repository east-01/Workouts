//
//  SetSubCell.swift
//  Workouts
//
//  Created by Ethan Mullen on 12/28/22.
//

import UIKit

/**
 The set subcell is responsible for displaying a single exercise and its respective rep counts
 It's split into two views:
    - The main view: Shows the main data that will be regularly shown
    - The button view: Shows the buttons for the exercise, like the swap button
 */
class SetSubCell: UIView {
    
    // Copy the height of the subcell so that we get square buttons
    static let BUTTON_WIDTH = SetCell.SUBCELL_SIZE;
    
    var exerciseUnit: ExerciseUnit
    
    var nameText: UILabel
    var setrepText: UILabel
    
    var mainView: UIView
    var mainViewRightConstraint: NSLayoutConstraint!
    
    var buttonView: UIView
    var buttonViewLeftConstraint: NSLayoutConstraint!
    
    init(exerciseUnit: ExerciseUnit) {
        self.exerciseUnit = exerciseUnit
        self.nameText = UILabel()
        self.setrepText = UILabel()
        self.mainView = UIView()
        self.buttonView = UIView()
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        createMainView()
        createButtonView()
        
        let panRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panCell))
        self.addGestureRecognizer(panRecognizer)
        
    }
        
    func createMainView() {
        
        // Create main view
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = UIColor(named: "BackgroundAccentColor2")
        mainView.layer.cornerRadius = 8
        mainView.isUserInteractionEnabled = true
        self.addSubview(mainView)

        // Main view constraints, have it fit the entire host view
        mainViewRightConstraint = mainView.rightAnchor.constraint(equalTo: self.rightAnchor)
        NSLayoutConstraint.activate([
            mainViewRightConstraint,
            mainView.widthAnchor.constraint(equalTo: self.widthAnchor),
            mainView.heightAnchor.constraint(equalTo: self.heightAnchor),
            mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        nameText = createTextLabel(text: exerciseUnit.exercise.data().displayName, isBold: false, fontSize: 35)
        nameText.adjustsFontSizeToFitWidth = true
        mainView.addSubview(nameText)

        setrepText = createTextLabel(text: exerciseUnit.createRepString(), isBold: true, fontSize: 35)
        setrepText.textAlignment = .right
        mainView.addSubview(setrepText)
                
        NSLayoutConstraint.activate([
            nameText.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: CGFloat(SetCell.SUBCELL_INTERIOR_PADDING)),
            nameText.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: CGFloat(-SetCell.SUBCELL_INTERIOR_PADDING)),
            nameText.topAnchor.constraint(equalTo: mainView.topAnchor, constant: CGFloat(SetCell.SUBCELL_INTERIOR_PADDING)),

            setrepText.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: CGFloat(SetCell.SUBCELL_INTERIOR_PADDING)),
            setrepText.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: CGFloat(-SetCell.SUBCELL_INTERIOR_PADDING))
        ])

    }
    
    func createButtonView() {
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = .cyan
        self.addSubview(buttonView)
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
//        stack.
        
        buttonViewLeftConstraint = buttonView.leftAnchor.constraint(equalTo: self.rightAnchor)
        NSLayoutConstraint.activate([
            buttonViewLeftConstraint,
            buttonView.widthAnchor.constraint(equalToConstant: CGFloat(SetSubCell.BUTTON_WIDTH * 2)),
            buttonView.heightAnchor.constraint(equalTo: self.heightAnchor),
            buttonView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
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

    @objc func panCell(_ sender: UIPanGestureRecognizer) {

        print(sender.translation(in: self))
        mainViewRightConstraint.constant = sender.translation(in: self).x
        buttonViewLeftConstraint.constant = sender.translation(in: self).x
        
    }
    
}
