//
//  WorkoutViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/23/22.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    static let UNIT_HEIGHT: Int = 100
    static let SPACE_HEIGHT: Int = 15
    static let HEADER_HEIGHT: Int = 50
    
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
            height += currentSet.exercises.count * WorkoutViewController.UNIT_HEIGHT
            height += WorkoutViewController.HEADER_HEIGHT
        }
        height += (workout.sets.count - 1) * WorkoutViewController.SPACE_HEIGHT
        // 50 = cell heiht, 15 = space size
        stackHeight.constant = CGFloat(height)
        
        for currentSet in workout.sets {
            let newCell: SetCell = SetCell(workoutSet: currentSet, position: stack.subviews.count + 1, totalCount: currentWorkout!.sets.count)
            stack.addArrangedSubview(newCell)
            
            NSLayoutConstraint.activate([
                newCell.leftAnchor.constraint(equalTo: stack.leftAnchor),
                newCell.rightAnchor.constraint(equalTo: stack.rightAnchor),
                newCell.heightAnchor.constraint(equalToConstant: CGFloat(currentSet.exercises.count * WorkoutViewController.UNIT_HEIGHT + WorkoutViewController.HEADER_HEIGHT))
            ])
        }
                        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.cornerRadius = 12
        
        
        
    }
        
}
