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
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var muscleGroupLabel: UILabel!
    @IBOutlet weak var equipmentLabel: UILabel!
    
    @IBOutlet weak var swapButton: UIButton!
    
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
        infoView.layer.cornerRadius = 12
        
        if(!currentWorkout!.canSwap(exercise!)) {
            swapButton.isHidden = true
        }
        
        let data = exercise!.data()
        
        titleLabel.text = data.displayName
        muscleGroupLabel.text = "\(data.genMuscleGroupString())"
        equipmentLabel.text = "\(data.genEquipomentString())"
        
        loadSwapExerciseView()
        
    }

    @IBAction func clickedCancel(_ sender: Any) {
        dismiss(animated: true)
    }
        
}
