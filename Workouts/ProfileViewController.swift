//
//  ProfileViewController.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/7/23.
//

import UIKit

class ProfileViewController: UIViewController {

    static let GYM_STACK_BUTTON_HEIGHT: Int = 50
    static let GYM_STACK_SPACING: Int = 5
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameChangeIcon: UIImageView!
    
    @IBOutlet weak var gymView: UIView!
    @IBOutlet weak var gymScrollView: UIScrollView!
    @IBOutlet weak var gymStack: UIStackView!
    @IBOutlet weak var gymStackHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.layer.cornerRadius = 12
        nameView.layer.cornerRadius = 12
        gymScrollView.layer.cornerRadius = 12
        gymView.layer.cornerRadius = 12
                
        nameView.addGestureRecognizer(createSimpleTapRecognizer())
        nameLabel.addGestureRecognizer(createSimpleTapRecognizer())
        nameChangeIcon.addGestureRecognizer(createSimpleTapRecognizer())

        showSettings()
        
    }
    
    // Show the current profile settings onto the ui
    func showSettings() {
        let userProfile = getProfile()
        nameLabel.text = userProfile.username
        
        // Add 1 for the plus button on the bottom
        gymStackHeight.constant = CGFloat(
            (userProfile.gyms.count+1)*ProfileViewController.GYM_STACK_BUTTON_HEIGHT + (userProfile.gyms.count)*ProfileViewController.GYM_STACK_SPACING
        )
        for i in 0...userProfile.gyms.count-1 {
            let gym = userProfile.gyms[i]
            let button: UIButton = UIButton()
            button.addTarget(self, action: #selector(tappedGym), for: .touchUpInside)
            button.tag = Int(i)
            button.setTitle(gym.name, for: .normal)
            button.backgroundColor = UIColor(named: "AccentColor")
            button.layer.cornerRadius = 8
            gymStack.addArrangedSubview(button)
        }
        
        let addButton: UIButton = UIButton()
        addButton.addTarget(self, action: #selector(tappedNewGym), for: .touchUpInside)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.backgroundColor = UIColor(named: "BackgroundAccentColor2")
        addButton.layer.cornerRadius = 8
        addButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        addButton.tintColor = UIColor(named: "ForegroundColor")
        gymStack.addArrangedSubview(addButton)
        
    }
    
    // Save the settings shown on the ui to current profile settings
    func saveSettings() {
        
    }
    
    @objc func tappedGym(_ sender: UIButton) {
        performSegue(withIdentifier: "toGymSettingsView", sender: sender.tag)
    }
    
    @objc func tappedNewGym(_ sender: UIButton) {
        performSegue(withIdentifier: "toGymSettingsView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toGymSettingsView") {
            let target = segue.destination as! GymSettingsViewController
            if(sender is Int) {
                target.gymIndex = sender as? Int
            }
        }
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
        let alert = UIAlertController(title: "Edit profile", message: "Enter name", preferredStyle: .alert)
        alert.addTextField { (textField) in }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            // Save user data
            var text = textField.text!
            if(text.isEmpty) {
                text = "User"
            }
            self.nameLabel.text = text
            self.saveSettings()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
