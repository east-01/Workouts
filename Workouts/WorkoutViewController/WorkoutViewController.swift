//
//  WorkoutViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/23/22.
//

import UIKit

/**
 Workout View Controller
 -
 */
class WorkoutViewController: UIViewController {
        
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var topSetCountLabel: UILabel!
    @IBOutlet weak var topMuscleGroupsLabel: UILabel!
    
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    
    // Note: Scroll view's delegate is set to self in WorkoutTopViewManager
    @IBOutlet weak var scrollView: UIScrollView!
    
    var setCells: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadTopView()
        
        scrollView.layer.cornerRadius = 12
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        loadStack()
    }
    
    func loadStack() {
        
        if(currentWorkout!.sets.count == 0) {
            return
        }
        
        stackHeight.constant = 0 // Reset the stack height to 0
        setCells = []
        
        for stackSubview in stack.arrangedSubviews {
            stackSubview.removeFromSuperview()
        }
        
        // Create and add each SetCell to the stack, dynamically expand the stack height
        for i in 0...currentWorkout!.sets.count-1 {
            let currentSet = currentWorkout!.sets[i]
            let newCell: SetCell = SetCell(workoutViewController: self, workoutSet: currentSet, position: stack.subviews.count + 1, totalCount: currentWorkout!.sets.count)
            NSLayoutConstraint.activate([
                newCell.heightAnchor.constraint(equalToConstant: CGFloat(newCell.getDesiredHeight()))
            ])
            setCells.append(newCell)
            stackHeight.constant += CGFloat(newCell.getDesiredHeight())
            if(i != 0) {
                stackHeight.constant += stack.spacing
            }
            stack.addArrangedSubview(newCell)
        }
                        
        // Add long press listeners
        for uiview in stack.subviews {
            let setCell: SetCell = uiview as! SetCell
            for setSubCell in setCell.subcellStack.subviews {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSubCell))
                tapGesture.numberOfTapsRequired = 1
                tapGesture.numberOfTouchesRequired = 1
                setSubCell.addGestureRecognizer(tapGesture)
            }
        }

    }
            
    // Tapped the home button. If the workout is complete, ask to save
    @IBAction func tappedHome(_ sender: Any) {
        saveCurrentWorkout()
    }
    
    // Tapped a sub cell, perform segue to exercise details
    @objc func tappedSubCell(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toExerciseDetails", sender: sender.view)
    }
 
    // Prepare to show exercise details
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toExerciseDetails") {
            let exerciseDetailsVC = segue.destination as! ExerciseDetailsViewController
            let exerciseSubcell = sender as! SetSubCell
            exerciseDetailsVC.exercise = exerciseSubcell.exerciseUnit.exercise
        }
    }
    
}
