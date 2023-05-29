//
//  HistoryViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 5/29/23.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var historyView: UIView!
    
    var stack: ExpandableStackView!
    var scrollView: UIScrollView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.layer.cornerRadius = 12
        historyView.layer.cornerRadius = 12
        
        // Create scroll view and add constraints
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.cornerRadius = 12
        scrollView.showsVerticalScrollIndicator = false
        historyView.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: historyView.topAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: historyView.bottomAnchor, constant: -10),
            scrollView.leftAnchor.constraint(equalTo: historyView.leftAnchor, constant: 10),
            scrollView.rightAnchor.constraint(equalTo: historyView.rightAnchor, constant: -10)
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

        loadWorkoutTiles()
        
    }
    
    func loadWorkoutTiles() {
        
        let userProfile = getProfile()
        
        for workout in userProfile.workoutHistory {
            let workoutTile = WorkoutTile(workout: workout)
            stack.addArrangedSubview(view: workoutTile)
            
            NSLayoutConstraint.activate([
                workoutTile.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
