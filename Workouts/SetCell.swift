//
//  SetCell.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/24/22.
//

import UIKit

@IBDesignable
class SetCell: UIView { // TODO Conver to StackView
    
    var workoutSet: WorkoutSet?
    
    var position: Int
    var totalCount: Int
    
    var cellHeader: UIView
    var numberText: UILabel
    var nameTexts: [UILabel]
    var setrepTexts: [UILabel]
    
    init(workoutSet: WorkoutSet, position: Int, totalCount: Int) {
        self.workoutSet = workoutSet
        self.position = position
        self.totalCount = totalCount
        self.cellHeader = UIView()
        self.numberText = UILabel()
        self.nameTexts = []
        self.setrepTexts = []
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.cellHeader = UIView()
        self.numberText = UILabel()
        self.nameTexts = []
        self.setrepTexts = []
        self.position = 0
        self.totalCount = 0
        super.init(coder: coder)
    }
        
    private func setup() {

        guard let workoutSet = workoutSet else {
            fatalError("Tried to setup a SetCell without an existing workoutSet")
        }
     
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "BackgroundAccentColor")
        self.layer.cornerRadius = 12
        
        createHeader()
        
        let colors: [UIColor] = [UIColor.orange, UIColor.systemRed, UIColor.systemBlue, UIColor.systemOrange, UIColor.systemCyan]
        
        for i in 0...workoutSet.exercises.count - 1 {
            let cell: UIView = createExerciseCell(exercise: workoutSet.exercises[i], sets: workoutSet.sets[i], reps: workoutSet.reps[i])
            cell.backgroundColor = colors[i]
            self.addSubview(cell)
            
            NSLayoutConstraint.activate([
                cell.leftAnchor.constraint(equalTo: self.leftAnchor),
                cell.rightAnchor.constraint(equalTo: self.rightAnchor),
                cell.heightAnchor.constraint(equalToConstant: CGFloat(WorkoutViewController.UNIT_HEIGHT))
            ])
                        
        }
        
        if(subviews.count > 1) {
            for i in 0...subviews.count - 1 {
                let cell = subviews[i]
                if(i == 0) {
                    NSLayoutConstraint.activate([
                        cell.topAnchor.constraint(equalTo: cellHeader.bottomAnchor),
                        cell.bottomAnchor.constraint(equalTo: subviews[i + 1].topAnchor),
                    ])
                } else if(i == subviews.count - 1) {
                    NSLayoutConstraint.activate([
                        cell.topAnchor.constraint(equalTo: subviews[i - 1].bottomAnchor),
                        cell.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        cell.topAnchor.constraint(equalTo: subviews[i - 1].bottomAnchor),
                        cell.bottomAnchor.constraint(equalTo: subviews[i + 1].topAnchor),
                    ])
                }
            }
        } else {
            NSLayoutConstraint.activate([
                subviews[0].topAnchor.constraint(equalTo: cellHeader.bottomAnchor),
                subviews[0].bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        }
    }
    
    private func createHeader() {
        
        cellHeader.backgroundColor = UIColor.systemYellow
        cellHeader.translatesAutoresizingMaskIntoConstraints = false
        
        numberText = createTextLabel(text: "\(position)/\(totalCount)", isBold: false, fontSize: 20)
        cellHeader.addSubview(numberText)
 
        NSLayoutConstraint.activate([
            numberText.leadingAnchor.constraint(equalTo: cellHeader.leadingAnchor, constant: CGFloat(15)),
            numberText.topAnchor.constraint(equalTo: cellHeader.topAnchor, constant: CGFloat(15))
        ])
        
    
        self.addSubview(cellHeader)
        
        NSLayoutConstraint.activate([
            cellHeader.leftAnchor.constraint(equalTo: self.leftAnchor),
            cellHeader.rightAnchor.constraint(equalTo: self.rightAnchor),
            cellHeader.topAnchor.constraint(equalTo: self.topAnchor),
            cellHeader.heightAnchor.constraint(equalToConstant: CGFloat(WorkoutViewController.HEADER_HEIGHT)),
        ])
        
    }
    
    private func createExerciseCell(exercise: Exercise, sets: Int, reps: Int) -> UIView {
        
        let cell: UIView = UIView()
        cell.translatesAutoresizingMaskIntoConstraints = false
                        
        let nameText = createTextLabel(text: exercise.getData().displayName, isBold: false, fontSize: 35)
        nameTexts.append(nameText)
        cell.addSubview(nameText)

        let setrepText = createTextLabel(text: "\(sets) x \(reps)", isBold: true, fontSize: 35)
        setrepText.textAlignment = .right
        setrepTexts.append(setrepText)
        cell.addSubview(setrepText)
                
        NSLayoutConstraint.activate([
            nameText.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: CGFloat(15)),
            nameText.centerYAnchor.constraint(equalTo: cell.centerYAnchor),

            setrepText.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: CGFloat(-15)),
            setrepText.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
        ])

        return cell
        
    }
    
    private func createTextLabel(text: String, isBold: Bool, fontSize: Float) -> UILabel {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = isBold ? .boldSystemFont(ofSize: CGFloat(fontSize)) : .systemFont(ofSize: CGFloat(fontSize))
        label.textColor = UIColor(named: "ForegroundColor")
        return label
    }
    
    func setWorkoutSet(workoutSet: WorkoutSet) {
        self.workoutSet = workoutSet
        setup()
    }

}
