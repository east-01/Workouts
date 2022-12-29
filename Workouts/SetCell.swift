//
//  SetCell.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/24/22.
//

import UIKit

@IBDesignable
class SetCell: UIView {
    
    static let SUBCELL_SIZE: Int = 120
    static let SUBCELL_SPACING: Int = 5
    static let SUBCELL_STACK_PADDING: Int = 5
    static let SUBCELL_INTERIOR_PADDING: Int = 10
    static let HEADER_HEIGHT: Int = 65
    static let HEADER_BUTTON_SIZE: Int = 40
    static let SPACE_HEIGHT: Int = 15

    var workoutSet: WorkoutSet?
    
    var position: Int
    var totalCount: Int
    
    var cellHeader: UIView
    var subcellStack: UIStackView
    var numberText: UILabel
    var nameTexts: [UILabel]
    var setrepTexts: [UILabel]
    
    init(workoutSet: WorkoutSet, position: Int, totalCount: Int) {
        self.workoutSet = workoutSet
        self.position = position
        self.totalCount = totalCount
        self.cellHeader = UIView()
        self.subcellStack = UIStackView()
        self.numberText = UILabel()
        self.nameTexts = []
        self.setrepTexts = []
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setup() {

        guard let workoutSet = workoutSet else {
            fatalError("Tried to setup a SetCell without an existing workoutSet")
        }
     
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "BackgroundAccentColor")
        self.layer.cornerRadius = 12
        
        createHeader()

        self.addSubview(subcellStack)
        subcellStack.translatesAutoresizingMaskIntoConstraints = false
        subcellStack.axis = .vertical
        subcellStack.spacing = CGFloat(SetCell.SUBCELL_SPACING)
        subcellStack.distribution = .equalSpacing

        NSLayoutConstraint.activate([
            subcellStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(5)),
            subcellStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(-5)),
            subcellStack.topAnchor.constraint(equalTo: cellHeader.bottomAnchor),
            subcellStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(-SetCell.SUBCELL_STACK_PADDING))
        ])
        
        for i in 0...workoutSet.exercises.count - 1 {
            let cell: SetSubCell = SetSubCell(setCell: self, exercise: workoutSet.exercises[i], sets: workoutSet.sets[i], reps: workoutSet.reps[i])
            
            NSLayoutConstraint.activate([
                cell.heightAnchor.constraint(equalToConstant: CGFloat(SetCell.SUBCELL_SIZE))
            ])

            subcellStack.addArrangedSubview(cell)

        }
        
    }
    
    private func createHeader() {
        
        cellHeader.translatesAutoresizingMaskIntoConstraints = false
        cellHeader.backgroundColor = UIColor(named:"AccentColor")
        cellHeader.layer.cornerRadius = 12
        cellHeader.layer.borderWidth = 5
        cellHeader.layer.borderColor = UIColor(named:"BackgroundAccentColor")?.cgColor

        self.addSubview(cellHeader)

        numberText = createTextLabel(text: "\(position)/\(totalCount)", isBold: false, fontSize: 30)
        cellHeader.addSubview(numberText)
 
        let completedButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        completedButton.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: CGFloat(SetCell.HEADER_BUTTON_SIZE)))
        completedButton.setImage(UIImage(systemName: "circle", withConfiguration: config), for: .normal)
        completedButton.tintColor = UIColor(named: "ForegroundColor")
        completedButton.backgroundColor = .clear
        completedButton.addTarget(self, action: #selector(clickedCompleteButton), for: .touchUpInside)
        cellHeader.addSubview(completedButton)
        
        NSLayoutConstraint.activate([
            cellHeader.topAnchor.constraint(equalTo: self.topAnchor),
            cellHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellHeader.heightAnchor.constraint(equalToConstant: CGFloat(SetCell.HEADER_HEIGHT))
        ])

        NSLayoutConstraint.activate([
            numberText.leadingAnchor.constraint(equalTo: cellHeader.leadingAnchor, constant: CGFloat(15)),
            numberText.centerYAnchor.constraint(equalTo: cellHeader.centerYAnchor),
            
            completedButton.widthAnchor.constraint(equalToConstant: CGFloat(SetCell.HEADER_BUTTON_SIZE)),
            completedButton.heightAnchor.constraint(equalToConstant: CGFloat(SetCell.HEADER_BUTTON_SIZE)),
            completedButton.trailingAnchor.constraint(equalTo: cellHeader.trailingAnchor, constant: CGFloat(-15)),
            completedButton.centerYAnchor.constraint(equalTo: cellHeader.centerYAnchor)
        ])
                        
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

    @objc func clickedCompleteButton(_ sender: UIButton) {
        guard let workout = currentWorkout else {
            return
        }
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: CGFloat(SetCell.HEADER_BUTTON_SIZE)))
        // Invert completion status then change button to reflect this
        workout.sets[position-1].isComplete = !workout.sets[position-1].isComplete
        let imageName = workout.sets[position-1].isComplete ? "checkmark.circle.fill" : "circle"
        sender.setImage(UIImage(systemName: imageName, withConfiguration: config), for: .normal)
    }
    
    public func getDesiredHeight() -> Int {
        let exCnt = workoutSet!.exercises.count
        return SetCell.HEADER_HEIGHT +
            SetCell.SUBCELL_SIZE * exCnt +
            SetCell.SUBCELL_SPACING * (exCnt - 1) +
            SetCell.SPACE_HEIGHT
    }
    
}
