//
//  DetailsViewManager.swift
//  Workouts
//
//  Created by Ethan Mullen on 5/28/23.
//

import Foundation
import UIKit

extension WorkoutSettingsViewController {
    
    static let SETTINGS_VIEW_HEIGHT_EXPANDED: CGFloat = 190
    static let SETTINGS_VIEW_HEIGHT_COLLAPSED: CGFloat = 140
    
    func setSettingsViewExpanded(_ expanded: Bool) {
        
        let animationDuration: TimeInterval = 0.15
        let subcellDuration: TimeInterval = 0.075
                
        showSupersetSizeRowWithFade(expanded, duration: subcellDuration, delay: expanded ? animationDuration : 0)
        
        UIView.animate(withDuration: animationDuration, delay: expanded ? 0 : subcellDuration, animations: {
            self.settingsViewHeight.constant = expanded ? WorkoutSettingsViewController.SETTINGS_VIEW_HEIGHT_EXPANDED : WorkoutSettingsViewController.SETTINGS_VIEW_HEIGHT_COLLAPSED
            self.view.layoutIfNeeded()
        })
        
    }
    
    func showSupersetSizeRowWithFade(_ show: Bool, duration: TimeInterval, delay: TimeInterval) {
        
        let elements: [UIView] = [supersetSizeDisplayText, supersetSizeText, supersetSizeStepper]
        
        UIView.animate(withDuration: duration, delay: delay) {
            for element in elements {
                element.alpha = show ? 1.0 : 0.0
                element.isUserInteractionEnabled = show
            }
        }
        
    }
    
}
