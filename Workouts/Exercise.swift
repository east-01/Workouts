//
//  Exercise.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/26/22.
//

import Foundation

enum Muscle {
    case NONE;
    // The general muscle groups
    case GEN_BICEP; case GEN_TRICEP; case GEN_ABS; case GEN_CHEST; case GEN_LEGS; case GEN_BACK; case GEN_SHOULDERS
    // Specific muscle groups
    case UPPER_CHEST; case LOWER_CHEST
    case QUADS; case HAMSTRING; case CALVES; case GLUTES
    case OBLIQUES; case UPPER_ABS; case LOWER_ABS
    case LOWER_BACK; case TRAPS
    
    func getGeneralGroup() -> Muscle {
        switch self{
        case .UPPER_CHEST: return .GEN_CHEST
        case .LOWER_CHEST: return .GEN_CHEST
        case .QUADS: return .GEN_LEGS
        case .HAMSTRING: return .GEN_LEGS
        case .CALVES: return .GEN_LEGS
        case .GLUTES: return .GEN_LEGS
        case .OBLIQUES: return .GEN_ABS
        case .UPPER_ABS: return .GEN_ABS
        case .LOWER_ABS: return .GEN_ABS
        case .LOWER_BACK: return .GEN_BACK
        case .TRAPS: return .GEN_BACK
        default: return .NONE
        }
    }
    
}

enum Exercise {
    
    case DB_CURLS; case DB_HAMMER_CURLS;
    case DB_BENCH; case DB_DECLINE_BENCH; case DB_INCLINE_BENCH;
    case BAR_CURLS;
    case BB_BENCH; case BB_DECLINE_BENCH; case BB_INCLINE_BENCH;
    case INCLINE_CHEST_FLY;
    case SHRUGS;
    case BB_TRI_EXT; case DB_TRI_EXT; case CABLE_PUSHDOWN; case DB_TRI_EXT_SINGLE; case DB_TRI_EXT_LEANING
    
    case LATERAL_RAISES;
    
    case DEADLIFT; case RDL_DEADLIFT; case BB_SQUAT; case LEG_PRESS; case LEG_EXTENSION; case LEG_CURLS;
    case SEATED_CALF_RAISES; case STANDING_CALF_RAISES

    func data() -> ExerciseData {
        switch self {
        case .DB_CURLS:
            return ExerciseData("Dumbbell Curls")
                .setMuscleGroups([.GEN_BICEP])
        case .DB_HAMMER_CURLS:
            return ExerciseData("Hammer Curls")
                .setMuscleGroups([.GEN_BICEP])
        case .DB_BENCH:
            return ExerciseData("Dumbbell Bench")
                .setMuscleGroups([.GEN_CHEST])
        case .DB_DECLINE_BENCH:
            return ExerciseData("Dumbbell Decline Bench")
                .setMuscleGroups([.LOWER_CHEST])
        case .DB_INCLINE_BENCH:
            return ExerciseData("Dumbbell Incline Bench")
                .setMuscleGroups([.UPPER_CHEST])
        case .BAR_CURLS:
            return ExerciseData("Bar Curls")
                .setMuscleGroups([.GEN_BICEP])
        case .BB_BENCH:
            return ExerciseData("Barbell Bench")
                .setMuscleGroups([.GEN_CHEST])
        case .BB_DECLINE_BENCH:
            return ExerciseData("Barbell Decline Bench")
                .setMuscleGroups([.LOWER_CHEST])
        case .BB_INCLINE_BENCH:
            return ExerciseData("Barbell Incline Bench")
                .setMuscleGroups([.UPPER_CHEST])
        case .INCLINE_CHEST_FLY:
            return ExerciseData("Incline Chest Fly")
                .setMuscleGroups([.GEN_CHEST, .GEN_SHOULDERS, .GEN_TRICEP])
        case .SHRUGS:
            return ExerciseData("Shrugs")
                .setMuscleGroups([.TRAPS, .GEN_SHOULDERS])
        case .BB_TRI_EXT:
            return ExerciseData("Barbell Tricep Ext.")
                .setMuscleGroups([.GEN_TRICEP])
        case .DB_TRI_EXT:
            return ExerciseData("Dumbbell Tricep Ext.")
                .setMuscleGroups([.GEN_TRICEP])
        case .CABLE_PUSHDOWN:
            return ExerciseData("Cable Pushdown")
                .setMuscleGroups([.GEN_TRICEP])
        case .DB_TRI_EXT_SINGLE:
            return ExerciseData("Single Overhead Tricep Ext.")
                .setMuscleGroups([.GEN_TRICEP, .OBLIQUES])
        case .DB_TRI_EXT_LEANING:
            return ExerciseData("Leaning Tricep Ext.")
                .setMuscleGroups([.GEN_TRICEP])
        case .LATERAL_RAISES:
            return ExerciseData("Lateral Raises")
                .setMuscleGroups([.GEN_SHOULDERS])
        case .DEADLIFT:
            return ExerciseData("Deadlift")
                .setMuscleGroups([.HAMSTRING, .QUADS, .GLUTES])
        case .RDL_DEADLIFT:
            return ExerciseData("RDL Deadlift")
                .setMuscleGroups([.HAMSTRING, .LOWER_BACK])
        case .BB_SQUAT:
            return ExerciseData("Barbell Squat")
                .setMuscleGroups([.QUADS, .GLUTES, .CALVES])
        case .LEG_PRESS:
            return ExerciseData("Leg Press")
                .setMuscleGroups([.QUADS, .GEN_ABS, .CALVES])
        case .LEG_EXTENSION:
            return ExerciseData("Leg Extension")
                .setMuscleGroups([.QUADS])
        case .LEG_CURLS:
            return ExerciseData("Leg Curls")
                .setMuscleGroups([.HAMSTRING])
        case .SEATED_CALF_RAISES:
            return ExerciseData("Seated Calf Raises")
                .setMuscleGroups([.CALVES])
        case .STANDING_CALF_RAISES:
            return ExerciseData("Standing Calf Raises")
                .setMuscleGroups([.CALVES])
        }
    }
    
}

class ExerciseData {
    var displayName: String
    var muscleGroups: [Muscle]
    init(_ dispName: String) {
        self.displayName = dispName
        self.muscleGroups = []
    }
    func setMuscleGroups(_ g: [Muscle]) -> ExerciseData {
        self.muscleGroups = g
        return self
    }
}
