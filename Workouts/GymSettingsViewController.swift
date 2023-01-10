//
//  GymSettingsViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/7/23.
//

import UIKit

class GymSettingsViewController: UIViewController {

    static var EXERCISE_STACK_BUTTON_HEIGHT = 55
    static var EXERCISE_STACK_SPACING = 10
    
    @IBOutlet weak var gymNameView: UIView!
    @IBOutlet weak var gymNameLabel: UILabel!
    @IBOutlet weak var gymNameIcon: UIImageView!
    
    @IBOutlet weak var equipmentView: UIView!
    @IBOutlet weak var equipmentScrollView: UIScrollView!
    @IBOutlet weak var equipmentStack: UIStackView!
    @IBOutlet weak var equipmentStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var saveButton: UIButton!
    
    // The index in the array of userProfile.gyms, if this number exists this means we're
    //   editing a gym, not creating a new one
    var gymIndex: Int?
    
    var gym: Gym = Gym(name: "New Gym", equipment: [])
    private var isValid = false
    
    private var equipmentSelections: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gym = Gym(name: "New Gym", equipment: [])
        isValid = false
        equipmentSelections = []
        
        if(gymIndex != nil) {
            gym = getProfile().gyms[gymIndex!]
        }
        
        gymNameView.layer.cornerRadius = 12
        equipmentView.layer.cornerRadius = 12
        equipmentScrollView.layer.cornerRadius = 8
        saveButton.layer.cornerRadius = 12
        
        gymNameView.addGestureRecognizer(createSimpleTapRecognizer())
        gymNameLabel.addGestureRecognizer(createSimpleTapRecognizer())
        gymNameIcon.addGestureRecognizer(createSimpleTapRecognizer())
        
        equipmentStack.spacing = CGFloat(GymSettingsViewController.EXERCISE_STACK_SPACING)
        equipmentStackHeight.constant = CGFloat(
            Equipment.allCases.count*GymSettingsViewController.EXERCISE_STACK_BUTTON_HEIGHT + (Equipment.allCases.count-1)*GymSettingsViewController.EXERCISE_STACK_SPACING
        )
        
        for i in 0...Equipment.allCases.count-1 {
            let button = UIButton()
            button.tag = i
            button.addTarget(self, action: #selector(tappedEquipmentButton), for: .touchUpInside)
            button.setTitle(String(describing: Equipment.allCases[i]), for: .normal)
            button.setTitleColor(UIColor(named: "ForegroundColor"), for: .normal)
            button.backgroundColor = UIColor(named: "BackgroundAccentColor2")
            button.layer.cornerRadius = 8
            equipmentStack.addArrangedSubview(button)
            let showActive: Bool = gym.equipment.contains(Equipment.allCases[i])
            equipmentSelections.append(showActive)
        }
                                  
        showSettings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showSettings()
    }
    
    func showSettings() {
                
        gymNameLabel.text = gym.name
        
        for i in 0...Equipment.allCases.count-1 {
            let showActive: Bool = gym.equipment.contains(Equipment.allCases[i])
            equipmentSelections[i] = showActive
            equipmentStack.arrangedSubviews[i].backgroundColor = UIColor(named: showActive ? "AccentColor" : "BackgroundAccentColor2")
        }
        
    }
    
    func saveSettings() {
        
        var isValid = true
        
        if(gymNameLabel.text!.isEmpty) {
            print("failed namelabel")
            isValid = false
        }
        
        var selectedEquipment: [Equipment] = []
        for i in 0...Equipment.allCases.count-1 {
            if(equipmentSelections[i]) {
                selectedEquipment.append(Equipment.allCases[i])
            }
        }
        
        if(selectedEquipment.count == 0) {
            print("failed selections")
            isValid = false
        }
        
        self.isValid = isValid
        UIView.animate(withDuration: 0.2, animations: {
            self.saveButton.backgroundColor = UIColor(named: isValid ? "AccentColor" : "BackgroundAccentColor2")
        })
        
        if(!isValid) {
            return
        }
        
        gym.name = gymNameLabel.text!
        gym.equipment = selectedEquipment
        
    }
    
    @objc func tappedEquipmentButton(_ sender: UIButton) {
        equipmentSelections[sender.tag] = !equipmentSelections[sender.tag]
        saveSettings()
        sender.backgroundColor = UIColor(named: equipmentSelections[sender.tag] ? "AccentColor" : "BackgroundAccentColor2")
    }
 
    @IBAction func tappedSave(_ sender: Any) {
        
        saveSettings()
        
        if(!isValid) { return }

        var profile = getProfile()

        if(gymIndex != nil) {
            profile.gyms[gymIndex!] = gym
        } else {
            profile.gyms.append(gym)
        }
        
        setProfile(profile: profile)
        
        dismiss(animated: true)
        
    }
    
    @IBAction func clickedCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func createSimpleTapRecognizer() -> UITapGestureRecognizer {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedName))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        return tapRecognizer
    }
    
    @objc func tappedName() {
        let alert = UIAlertController(title: "Edit gym", message: "Enter gym name", preferredStyle: .alert)
        alert.addTextField { (textField) in }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            // Save user data
            var text = textField.text!
            if(text.isEmpty) {
                text = "Gym"
            }
            self.gymNameLabel.text = text
            self.saveSettings()
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
