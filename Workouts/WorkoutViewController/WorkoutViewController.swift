//
//  WorkoutViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/23/22.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var progressLayer: CALayer?
    @IBOutlet weak var doneButton: UIButton!
    
    var setCells: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleView.layer.cornerRadius = 12
        scrollView.layer.cornerRadius = 12

        stack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false

        guard let workout = currentWorkout else {
            print("Failed to get current workout")
            return;
        }
        
        titleLabel.text = workout.name

    }
        
    override func viewWillAppear(_ animated: Bool) {
        loadStack()
        updateDoneButton()
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
    
    func updateDoneButton() {
        guard let workout = currentWorkout else { return }
        // If the progressLayer doesn't exist make a new one and add it
        if(progressLayer == nil) {
            progressLayer = CALayer()
            progressLayer!.cornerRadius = 8
            progressLayer!.backgroundColor = (UIColor(named: "AccentColor")?.cgColor)
            doneButton.layer.insertSublayer(progressLayer!, at: 1)
        }
        // Modify the progressLayer's width to show progress
        let progress = workout.progress()
        progressLayer!.frame = CGRect(x: doneButton.bounds.minX, y: doneButton.bounds.minY, width: doneButton.bounds.width * CGFloat(progress), height: doneButton.bounds.height)
        // Update the button's text color
        let nextColor = progress == 1 ? UIColor(named: "ForegroundColor") : .clear
        UIView.transition(with: doneButton.titleLabel!, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.doneButton.titleLabel!.textColor = nextColor
            self.doneButton.tintColor = nextColor
        })
    }
    
    @IBAction func tappedDoneButton(_ sender: Any) {
        guard let workout = currentWorkout else { return }
        if(workout.progress() != 1) { return }
        // TODO Save current workout to workout history
        currentWorkout = nil
        saveCurrentWorkout()
        performSegue(withIdentifier: "toMainView", sender: self)
    }
    
    // Tapped the back button in the upper left, auto segues to main view
    @IBAction func tappedBack(_ sender: Any) {
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
