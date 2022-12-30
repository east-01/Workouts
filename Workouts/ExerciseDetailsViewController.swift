//
//  ExerciseDetailsViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 12/29/22.
//

import UIKit

class ExerciseDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var exercise: Exercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = exercise?.data().displayName
    }

    @IBAction func clickedSettings(_ sender: Any) {
        
    }
    
}
