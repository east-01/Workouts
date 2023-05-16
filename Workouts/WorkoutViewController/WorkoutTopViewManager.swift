//
//  WorkoutTopViewManager.swift
//  Workouts
//
//  Created by Ethan Mullen on 5/16/23.
//

import Foundation
import UIKit

/**
 Workout Top View Manager
 Controls the top view of the workout view, manages whether the top view should be expanded or not
 */
extension WorkoutViewController: UIScrollViewDelegate {
   
    static let TOP_VIEW_HEIGHT_EXPANDED: CGFloat = 120
    static let TOP_VIEW_HEIGHT_COLLAPSED: CGFloat = 65
    
    func loadTopView() {
        
        topView.layer.cornerRadius = 12
        
        scrollView.delegate = self
        
        guard let workout = currentWorkout else {
            print("Failed to get current workout")
            return;
        }

        topTitleLabel.text = workout.name
        topSetCountLabel.text = "\(workout.sets.count) set\(workout.sets.count > 1 ? "s" : "")"
        topMuscleGroupsLabel.text = workout.muscleListString()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y <= 0 && !isTopViewExpanded()) {
            setTopViewExpanded(expanded: true)
        } else if(scrollView.contentOffset.y > 0 && isTopViewExpanded()) {
            setTopViewExpanded(expanded: false)
        }
    }
    
    func setTopViewExpanded(expanded: Bool) {
        
        topViewHeight.constant = expanded ? WorkoutViewController.TOP_VIEW_HEIGHT_EXPANDED : WorkoutViewController.TOP_VIEW_HEIGHT_COLLAPSED
        let animationDuration: TimeInterval = 0.15
        let textDuration: TimeInterval = 0.075
        
        // If we're expanding the view, we need to wait for the expanding animation to complete first.
        // If we're collapsing the view, we need to fade away the text first
        showTextWithFade(show: expanded, duration: textDuration, delay: expanded ? animationDuration : 0)
        
        UIView.animate(withDuration: animationDuration, delay: expanded ? 0 : textDuration, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func showTextWithFade(show: Bool, duration: TimeInterval, delay: TimeInterval) {
        
        var labels: [UILabel] = []
        labels.append(topSetCountLabel)
        labels.append(topMuscleGroupsLabel)

        // Since we're showing the labels, we're assuming that they're already disabled and with opacity zero
        if(show) {
            for label in labels {
                label.isEnabled = true
            }
        }
        
        UIView.animate(withDuration: duration, delay: delay, animations: {
            for label in labels {
                label.layer.opacity = show ? 1.0 : 0.0;
            }
        }, completion: { _ in
            for label in labels {
                label.isEnabled = show
            }
        })
        
    }
    
    func isTopViewExpanded() -> Bool {
        return topViewHeight.constant == WorkoutViewController.TOP_VIEW_HEIGHT_EXPANDED
    }
    
}
