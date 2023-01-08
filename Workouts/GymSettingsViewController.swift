//
//  GymSettingsViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/7/23.
//

import UIKit

class GymSettingsViewController: UIViewController {

    // The index in the array of userProfile.gyms, if this number exists this means we're
    //   editing a gym, not creating a new one
    var gymIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Loaded index: \(gymIndex)")
        
    }
    
}
