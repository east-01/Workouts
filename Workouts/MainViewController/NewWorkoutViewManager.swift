//
//  NewWorkoutViewManager.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/4/23.
//

import Foundation
import UIKit

extension MainViewController {
    
    func loadNewWorkoutView() {
        
        newWorkoutView = NewWorkoutView(mainViewController: self)
        view.addSubview(newWorkoutView!)
        
        NSLayoutConstraint.activate([
            newWorkoutView!.topAnchor.constraint(equalTo: view.topAnchor),
            newWorkoutView!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newWorkoutView!.leftAnchor.constraint(equalTo: view.leftAnchor),
            newWorkoutView!.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        newWorkoutView!.isHidden = true

    }
    
    @IBAction func newWorkoutClicked(_ sender: Any) {
        setToggleButtonLarge(val: false)
        newWorkoutView!.isHidden = false
        newWorkoutView!.showButtons(val: true)
    }
    
    @objc func tappedNewWorkoutView(_ sender: UITapGestureRecognizer) {
        setToggleButtonLarge(val: true)
        newWorkoutView!.showButtons(val: false)
    }
    
    @objc func tappedFromSettings(_ sender: UIButton) {
        newWorkoutView!.showButtons(val: false)
        performSegue(withIdentifier: "toWorkoutSettingsView", sender: self)
    }
    
    @objc func tappedFromSchedule(_ sender: UIButton) {
        newWorkoutView!.showButtons(val: false)
        currentWorkout = Workout(settings: getTodaysSettings()!)
        performSegue(withIdentifier: "toWorkoutView", sender: self)
    }
    
    func setToggleButtonLarge(val: Bool) {
        self.newWorkoutButtonWidth.constant = val ? 120 : 80
        self.newWorkoutButtonHeight.constant = val ? 120 : 80
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func toggleNewWorkoutButtonSize() {
        let currW = self.newWorkoutButtonWidth.constant
        setToggleButtonLarge(val: currW != 120)
    }
        
}

class NewWorkoutView: UIView {
    
    static let BUTTON_HEIGHT: Int = 55
    static let BUTTON_SPACING: Int = 10
    static let STACK_BOTTOM_POSITION: Int = -130
    
    var mainViewController: MainViewController
    
    var stack: UIStackView = UIStackView()
    var stackHeight: CGFloat = .zero
    var buttons: [UIButton] = []
    var stackBottomAnchor: NSLayoutConstraint = NSLayoutConstraint()
    
    init(mainViewController: MainViewController) {

        self.mainViewController = mainViewController

        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let tapRecognizer = UITapGestureRecognizer(target: mainViewController, action: #selector(mainViewController.tappedNewWorkoutView))
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapRecognizer)
                
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = CGFloat(NewWorkoutView.BUTTON_SPACING)
        stack.distribution = .fillEqually
        self.addSubview(stack)

        buttons = []
        if(getTodaysSettings() != nil) {
            let fromSchedule = createButton(text: "Create from schedule", selector: #selector(mainViewController.tappedFromSchedule))
            buttons.append(fromSchedule)
        }
        let fromSettings = createButton(text: "Create from settings", selector: #selector(mainViewController.tappedFromSettings))
        buttons.append(fromSettings)
        
        stackHeight = CGFloat((buttons.count * NewWorkoutView.BUTTON_HEIGHT) + (Int(buttons.count-1) * NewWorkoutView.BUTTON_SPACING))
        stackBottomAnchor = stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(stackHeight)) // Start at this position because it's "offscreen"
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            stackBottomAnchor,
            stack.heightAnchor.constraint(equalToConstant: stackHeight)
        ])
        
        for button in buttons {
            stack.addArrangedSubview(button)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showButtons(val: Bool) {
        
        stackBottomAnchor.constant = CGFloat(val ? NewWorkoutView.STACK_BOTTOM_POSITION : 1000)
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            self.layoutIfNeeded()
        }, completion: { _ in
            if(!val) {
                self.isHidden = true
            }
        })
        
    }
    
    private func createButton(text: String, selector: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(mainViewController, action: selector, for: .touchUpInside)
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor(named: "ForegroundColor"), for: .normal)
        button.backgroundColor = UIColor(named: "AccentColor")
        button.layer.cornerRadius = 8
        return button
    }
    
}
