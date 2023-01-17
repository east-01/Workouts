//
//  ExerciseDetailsViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 12/29/22.
//

import UIKit

class ExerciseDetailsViewController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var settingsOverlay: OverlayView?
    var checkboxStack: UIStackView?
    static let checkboxOptions: [String] = [
        "Can't do this exercise at this gym",
        "I don't like it",
        "It doesn't fit in this workout"
    ]
    
    var exercise: Exercise?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(exercise == nil) { return }
        
        titleView.layer.cornerRadius = 12
        titleLabel.text = exercise!.data().displayName
        
        loadSwapExerciseView()
        
    }

    @IBAction func clickedCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
