//
//  WorkoutViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/23/22.
//

import UIKit

class WorkoutViewController: UIViewController {
        
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
        
    @IBOutlet weak var scrollView: UIScrollView!
    
    var setCells: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        guard let workout = currentWorkout else {
            print("Failed to get current workout")
            return;
        }

        titleLabel.text = workout.name
        typeLabel.text = "Default";
                
        print("Loading workout with \(workout.sets.count) sets")
                
        // Create and add each SetCell to the stack, dynamically expand the stack height
        for i in 0...workout.sets.count-1 {
            let currentSet = workout.sets[i]
            let newCell: SetCell = SetCell(workoutSet: currentSet, position: stack.subviews.count + 1, totalCount: workout.sets.count)
            NSLayoutConstraint.activate([
                newCell.heightAnchor.constraint(equalToConstant: CGFloat(newCell.getDesiredHeight()))
            ])
            stackHeight.constant += CGFloat(newCell.getDesiredHeight())
            stack.addArrangedSubview(newCell)
        }
         
        print(stackHeight.constant)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.cornerRadius = 12
        
    }
        
}
