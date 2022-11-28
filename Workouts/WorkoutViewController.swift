//
//  WorkoutViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/23/22.
//

import UIKit

class WorkoutViewController: UIViewController {
        
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
        
    @IBOutlet weak var scrollView: UIScrollView!
    
    var setCells: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateLabel.text = dateFormatter.string(from: date)
        typeLabel.text = "Default";
        
        guard let workout = currentWorkout else {
            return;
        }
        
        var height: Int = 0
        for currentSet in workout.sets {
            height += currentSet.exercises.count * SetCell.UNIT_HEIGHT
            height += SetCell.HEADER_HEIGHT
        }
        height += (workout.sets.count - 1) * SetCell.SPACE_HEIGHT
        stackHeight.constant = CGFloat(height)
        
        for currentSet in workout.sets {
            let newCell: SetCell = SetCell(workoutSet: currentSet, position: stack.subviews.count + 1, totalCount: currentWorkout!.sets.count)
            stack.addArrangedSubview(newCell)
            
            NSLayoutConstraint.activate([
                newCell.heightAnchor.constraint(equalToConstant: CGFloat(currentSet.exercises.count * SetCell.UNIT_HEIGHT + SetCell.HEADER_HEIGHT))
            ])
        }
                        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.cornerRadius = 12
        
    }
        
}
