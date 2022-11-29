//
//  SetCell.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/24/22.
//

import UIKit

@IBDesignable
class SetCell: UIStackView {
    
    static let UNIT_HEIGHT: Int = 55
    static let SPACE_HEIGHT: Int = 15
    static let HEADER_HEIGHT: Int = 50

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
    
    required init(coder: NSCoder) {
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
        self.axis = .vertical
        self.spacing = .zero
        self.distribution = .equalSpacing
        
        createHeader()
                
        for i in 0...workoutSet.exercises.count - 1 {
            let cell: UIView = createExerciseCell(exercise: workoutSet.exercises[i], sets: workoutSet.sets[i], reps: workoutSet.reps[i])
            self.addArrangedSubview(cell)
            
            NSLayoutConstraint.activate([
                cell.heightAnchor.constraint(equalToConstant: CGFloat(SetCell.UNIT_HEIGHT))
            ])
                        
        }
        
    }
    
    private func createHeader() {
        
        cellHeader.translatesAutoresizingMaskIntoConstraints = false
        cellHeader.backgroundColor = UIColor(named:"AccentColor")
        cellHeader.layer.cornerRadius = 12
        cellHeader.layer.borderWidth = 5
        cellHeader.layer.borderColor = UIColor(named:"BackgroundAccentColor")?.cgColor

        self.addArrangedSubview(cellHeader)

        numberText = createTextLabel(text: "\(position)/\(totalCount)", isBold: false, fontSize: 20)
        cellHeader.addSubview(numberText)
 
        NSLayoutConstraint.activate([
            numberText.leadingAnchor.constraint(equalTo: cellHeader.leadingAnchor, constant: CGFloat(15)),
            numberText.centerYAnchor.constraint(equalTo: cellHeader.centerYAnchor)
        ])
                
        NSLayoutConstraint.activate([
            cellHeader.heightAnchor.constraint(equalToConstant: CGFloat(SetCell.HEADER_HEIGHT)),
        ])
        
    }
    
    private func createExerciseCell(exercise: Exercise, sets: Int, reps: Int) -> UIView {
        
        let cell: UIView = UIView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        
        let nameText = createTextLabel(text: exercise.getData().displayName, isBold: false, fontSize: 35)
        nameText.adjustsFontSizeToFitWidth = true
        nameTexts.append(nameText)
        cell.addSubview(nameText)

        let setrepText = createTextLabel(text: "\(sets) x \(reps)", isBold: true, fontSize: 35)
        setrepText.textAlignment = .right
        setrepTexts.append(setrepText)
        cell.addSubview(setrepText)
                
        NSLayoutConstraint.activate([
            nameText.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: CGFloat(15)),
            nameText.trailingAnchor.constraint(equalTo: setrepText.leadingAnchor, constant: CGFloat(-15)),
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
