//
//  Muscle.swift
//  Workouts
//
//  Created by Ethan Mullen on 12/24/22.
//

import Foundation

enum Muscle: CaseIterable, Codable {

    case NONE;
    // The general muscle groups
    case GEN_BICEP; case GEN_TRICEP; case GEN_ABS; case GEN_CHEST; case GEN_LEGS; case GEN_BACK; case GEN_SHOULDERS
    // Specific muscle groups
    case UPPER_CHEST; case LOWER_CHEST
    case FRONT_DELTS; case MIDDLE_DELTS; case REAR_DELTS; case ROTATOR_CUFF
    case QUADS; case HAMSTRING; case CALVES; case GLUTES
    case OBLIQUES; case UPPER_ABS; case LOWER_ABS
    case LOWER_BACK; case MID_BACK; case TRAPS; case LATS
    
    func getGeneralGroup() -> Muscle {
        switch self{
        case .UPPER_CHEST: return .GEN_CHEST
        case .LOWER_CHEST: return .GEN_CHEST
        case .FRONT_DELTS: return .GEN_SHOULDERS
        case .MIDDLE_DELTS: return .GEN_SHOULDERS
        case .REAR_DELTS: return .GEN_SHOULDERS
        case .ROTATOR_CUFF: return .GEN_SHOULDERS
        case .QUADS: return .GEN_LEGS
        case .HAMSTRING: return .GEN_LEGS
        case .CALVES: return .GEN_LEGS
        case .GLUTES: return .GEN_LEGS
        case .OBLIQUES: return .GEN_ABS
        case .UPPER_ABS: return .GEN_ABS
        case .LOWER_ABS: return .GEN_ABS
        case .LOWER_BACK: return .GEN_BACK
        case .MID_BACK: return .GEN_BACK
        case .TRAPS: return .GEN_BACK
        case .LATS: return .GEN_BACK
        default: return self
        }
    }
    
    func getDisplayName() -> String {
        switch self{
        case .GEN_BICEP: return "Biceps"
        case .GEN_TRICEP: return "Triceps"
        case .GEN_ABS: return "Abs"
        case .GEN_CHEST: return "Chest"
        case .GEN_LEGS: return "Legs"
        case .GEN_BACK: return "Back"
        case .GEN_SHOULDERS: return "Shoulders"
        default: return String(describing: self)
        }
    }
    
    static func getGeneralGroups() -> [Muscle] {
        return [.GEN_BICEP, .GEN_TRICEP, .GEN_ABS, .GEN_CHEST, .GEN_LEGS, .GEN_BACK, .GEN_SHOULDERS]
    }
    
}
