//
//  OverlayView.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/15/23.
//

import UIKit

// Class that creates an invisible view that is supposed to cover the screen.
// When tapped, this view will hide itself.
class OverlayView: UIView, UIGestureRecognizerDelegate {

    var centerView: UIView?
    
    init(superview: UIView) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

        self.translatesAutoresizingMaskIntoConstraints = false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedView))
        tapGestureRecognizer.delegate = self
        self.addGestureRecognizer(tapGestureRecognizer)
        
        superview.addSubview(self)
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedView(_ sender: UITapGestureRecognizer) {
        hide()
    }
    
    func show() {
        self.isHidden = false
        self.alpha = 0
        UIView.animate(withDuration: TimeInterval(0.1), delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 1
        })
    }
    
    func hide() {
        self.alpha = 1
        UIView.animate(withDuration: TimeInterval(0.1), delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.isHidden = true
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return gestureRecognizer.view === touch.view
    }
    
    func createCenterView(insets: UIEdgeInsets) {
        
        centerView = UIView()
        centerView!.translatesAutoresizingMaskIntoConstraints = false
        centerView!.backgroundColor = UIColor(named: "BackgroundAccentColor")
        centerView!.layer.cornerRadius = 12
        
        self.addSubview(centerView!)
        
        NSLayoutConstraint.activate([
            centerView!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left),
            centerView!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: insets.right),
            centerView!.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top),
            centerView!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.bottom)
        ])
        
    }
    
}
