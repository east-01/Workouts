//
//  ExpandableStackView.swift
//  Workouts
//
//  Created by Ethan Mullen on 5/17/23.
//

import Foundation
import UIKit

class ExpandableStackView: UIView {
        
    var arrangedSubviews: [UIView]
    private var topConstraints: [NSLayoutConstraint]
    private var bottomConstraint: NSLayoutConstraint!
    private var spacing: CGFloat
    
    init() {
        arrangedSubviews = []
        topConstraints = []
        spacing = 0
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addArrangedSubview(view: UIView) {
        
        arrangedSubviews.append(view)
        addSubview(view)
        
        // Since this is a vertical stack view, all subviews will expand to the left and right to fill stack view
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: self.leftAnchor),
            view.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
        
        // If this view is the only new subview, this one will fill the entire stack view
        if(arrangedSubviews.count == 1) {
            let topConstraint: NSLayoutConstraint = view.topAnchor.constraint(equalTo: self.topAnchor)
            bottomConstraint = view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            NSLayoutConstraint.activate([
                topConstraint,
                bottomConstraint,
            ])
            topConstraints.append(topConstraint)
            return
        }
        
        // Remove the bottom index of the old bottom view, it's no longer the last one in the stack
        bottomConstraint.isActive = false
        
        // Create new constraints
        let topConstraint = view.topAnchor.constraint(equalTo: arrangedSubviews[arrangedSubviews.count-2].bottomAnchor, constant: spacing)
        bottomConstraint = view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        // Reset the old bottom constraint for the above view in the array, then add new constraints
        topConstraints.append(topConstraint)
        
        // Activate the constraints
        NSLayoutConstraint.activate([
            topConstraint,
            bottomConstraint
        ])
        
    }
    
    func setSpacing(spacing: CGFloat) {
        self.spacing = spacing
    }
    
    /**
     This function will clear all subiews in the ExpandableStackView and reset the constraints back to their initial (empty) state.
     */
    func clearSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        arrangedSubviews = []
        topConstraints = []
        bottomConstraint = nil
    }
    
}
