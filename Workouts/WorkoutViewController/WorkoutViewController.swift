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
    
    @IBOutlet weak var bottomView: UIView!
    
    var stack: ExpandableStackView!
    
    // Note: Scroll view's delegate is set to self in WorkoutTopViewManager
    var scrollView: UIScrollView!
    
    var setCells: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create scroll view and add constraints
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.cornerRadius = 12
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -10),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
        
        // Create the expandable stack view for inside the scroll view and add constraints
        stack = ExpandableStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setSpacing(spacing: 10)
        scrollView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        loadTopView()
                
    }
        
    override func viewWillAppear(_ animated: Bool) {
        loadStack()
    }
    
    func loadStack() {
        
        if(currentWorkout!.sets.count == 0) {
            return
        }
                
        // Reset old setCells
        setCells = []
        stack.clearSubviews()
        
        // Create new setcells and add them to the stack view
        for i in 0..<currentWorkout!.sets.count {
            let currentSet = currentWorkout!.sets[i]
            let newCell: SetCell = SetCell(workoutViewController: self, workoutSet: currentSet, position: stack.subviews.count + 1, totalCount: currentWorkout!.sets.count)
            let newCellHeightAnchor: NSLayoutConstraint = newCell.heightAnchor.constraint(equalToConstant: CGFloat(newCell.getDesiredHeight()))
            NSLayoutConstraint.activate([
                newCellHeightAnchor
            ])
            newCell.setHeightConstraint(constraint: newCellHeightAnchor)
            setCells.append(newCell)
            stack.addArrangedSubview(view: newCell)
            
            if(currentSet.isComplete) {
                newCell.setExpanded(expanded: false, animate: false)
            }
            
        }
        
        // Add long press listeners
        for uiview in stack!.subviews {
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
        if(currentWorkout!.progress() == 1 && currentProfile != nil) {
            currentProfile!.workoutHistory.append(currentWorkout!)
            saveProfile()
            currentWorkout = nil
        }
        saveCurrentWorkout()
        performSegue(withIdentifier: "toMainView", sender: self)
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
