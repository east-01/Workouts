//
//  Exercise.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/26/22.
//

import Foundation

enum Muscle {
    case NONE; case GEN_BICEP; case GEN_UPPER_ABS; case GEN_LOWER_ABS; case OBLIQUES
}

enum Exercise {
    
    case DB_CURLS; case DB_HAMMER_CURLS;
    case BB_BENCH; case BB_DECLINE_BENCH; case BB_INCLINE_BENCH;
    case DB_BENCH; case DB_DECLINE_BENCH; case DB_INCLINE_BENCH;
    case BAR_CURLS;
    case SHRUGS;
    
    case LATERAL_RAISES;
    
    case DEADLIFT;

    func getData() -> ExerciseData {
        switch self {
        case .DEADLIFT:
            return ExerciseData(
                dispName: "Deadlift",
                priMuscle: .NONE,
                secMuscle: .NONE,
                terMuscle: .NONE
            )
        case .DB_HAMMER_CURLS:
            return ExerciseData(
                dispName: "Hammer Curls",
                priMuscle: .NONE,
                secMuscle: .NONE,
                terMuscle: .NONE
            )
        case .SHRUGS:
            return ExerciseData(
                dispName: "Shrugs",
                priMuscle: .NONE,
                secMuscle: .NONE,
                terMuscle: .NONE
            )
        case .DB_DECLINE_BENCH:
            return ExerciseData(
                dispName: "Dumbbell Decline Bench",
                priMuscle: .NONE,
                secMuscle: .NONE,
                terMuscle: .NONE
            )
        case .LATERAL_RAISES:
            return ExerciseData(
                dispName: "Lateral Raises",
                priMuscle: .NONE,
                secMuscle: .NONE,
                terMuscle: .NONE
            )
        case .BAR_CURLS:
            return ExerciseData(
                dispName: "Bar Curls",
                priMuscle: .NONE,
                secMuscle: .NONE,
                terMuscle: .NONE
            )
        case .BB_BENCH:
            return ExerciseData(
                dispName: "Barbell Bench",
                priMuscle: .NONE,
                secMuscle: .NONE,
                terMuscle: .NONE
            )
        default:
            fatalError("Failed to get data for \(String(describing: self))")
        }
    }
    
}

struct ExerciseData {
    var displayName: String
    var primaryMuscle: Muscle
    var secondaryMuscle: Muscle
    var tertiaryMuscle: Muscle
    init(dispName: String, priMuscle: Muscle, secMuscle: Muscle, terMuscle: Muscle) {
        self.displayName = dispName
        self.primaryMuscle = priMuscle
        self.secondaryMuscle = secMuscle
        self.tertiaryMuscle = terMuscle
    }
}

