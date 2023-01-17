//
//  CheckBoxWithText.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/16/23.
//

import UIKit

class CheckBoxWithText: UIView {
    
    var imageView: UIImageView
    var textLabel: UILabel
    
    private var state: Bool
    
    init(text: String) {
             
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(named: "ForegroundColor")
        
        textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = text
        textLabel.textColor = UIColor(named: "ForegroundColor")
        
        state = false

        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.translatesAutoresizingMaskIntoConstraints = false

        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedCheck)))
        textLabel.isUserInteractionEnabled = true
        textLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedCheck)))
        
        addSubview(imageView)
        addSubview(textLabel)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: self.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        updateImage()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedCheck() {
        setState(newState: !state)
    }
    
    func getState() -> Bool {
        return state
    }
    
    func setState(newState: Bool) {
        self.state = newState
        updateImage()
    }
    
    private func updateImage() {
        imageView.image = UIImage(systemName: state ? "checkmark.square.fill" : "square")
    }
    
}
