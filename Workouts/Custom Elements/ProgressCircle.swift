//
//  ProgressCircle.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/29/22.
//

import UIKit

class ProgressCircle: UIView {

    var progress: Float
    var text: String
    var circleFGCol: UIColor
    var circleBGCol: UIColor
    var lineWidth = 12
    
    var textLabel: UILabel = UILabel()
    
    init(progress: Float, color: UIColor, text: String) {
        self.progress = progress
        self.circleFGCol = color
        self.circleBGCol = .gray
        if let defBGCol = UIColor(named: "BackgroundAccentColor2") {
            self.circleBGCol = defBGCol
        }
        self.text = text
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.progress = 0
        self.circleFGCol = .systemRed
        if let accentColor = UIColor(named: "AccentColor") {
            self.circleFGCol = accentColor
        }
        self.circleBGCol = .gray
        if let defBGCol = UIColor(named: "BackgroundAccentColor2") {
            self.circleBGCol = defBGCol
        }
        self.text = ""
        super.init(coder: coder)
        setup()
    }

    func setup() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = self.text
        textLabel.textColor = .red
        textLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: CGFloat(-2*lineWidth - 5))
        ])
        
    }
    
    override func draw(_ rect: CGRect) {
        
        if let context = UIGraphicsGetCurrentContext(){
            
            let radius: CGFloat = (rect.width / 2) - CGFloat(lineWidth / 2)

            context.setLineWidth(CGFloat(lineWidth))
            
            // Draw background
            context.addArc(
                center: CGPoint(x: rect.width / 2, y: rect.height / 2),
                radius: radius,
                startAngle: 0,
                endAngle: 2*Double.pi,
                clockwise: false)
            context.setStrokeColor(circleBGCol.cgColor)
            context.drawPath(using: CGPathDrawingMode.stroke)
            
            let startAngle: CGFloat = 0
            let endAngle: CGFloat = (2*Double.pi) * Double(progress)
            
            // Draw the actual angle
            context.addArc(
                center: CGPoint(x: rect.width / 2, y: rect.height / 2),
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false)
            context.setStrokeColor(circleFGCol.cgColor)
            context.setLineCap(CGLineCap.round)
            context.drawPath(using: CGPathDrawingMode.stroke)
        }
        
        super.draw(rect)
        
    }
    
}
