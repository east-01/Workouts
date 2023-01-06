//
//  Equipment.swift
//  Workouts
//
//  Created by Ethan Mullen on 1/5/23.
//

import Foundation

enum Equipment: Codable, CaseIterable {
    
    case NONE; case BODYWEIGHT;
    
    // "Home gym" equipment - Anything thats reasonable to be at a home gym
    case DUMBBELLS; case BARBELL;
    case BENCH; case INCLINE_BENCH; case DECLINE_BENCH
    case LONG_BAND;
    case PULL_UP_BAR;
    case SQUAT_RACK;
    
    // Commercial gym equipment
    case EZ_BAR;
    case PRE_WEIGHTED_BARBELL; case PRE_WEIGHTED_EZ_BAR;
    case T_BAR_ROW_STATION; case V_HANDLE;
    case ELBOW_SUPPORTED_APPARATUS; case DIPS_HANDLES;
    case TRAP_BAR;
    case PREACHER_CURL_BENCH;
    
    // Cable machine accessories
    case CABLE_MACHINE;
    case HANDLE_ATTACHMENT; case LONG_BAR_ATTACHMENT; case SMALL_STRAIGHT_BAR_ATTACHMENT; case ANKLE_STRAP_ATTACHMENT;
    case ROPE_ATTACHMENT; case TWO_HANDLE_ATTACHMENTS; case CLOSE_GRIP_ATTACHMENT;
    
    // Isolation machines
    case BICEP_CURL_MACHINE; case CHEST_PRESS_MACHINE; case PEC_DECK_MACHINE;
    case ASSISTED_PULL_UP_DIPS_MACHINE; case LATERAL_SHOULDER_RAISE_MACHINE;
    case SEATED_HAMSTRING_CURL_MACHINE; case BENT_OVER_CALF_RAISE_MACHINE; case LYING_HAMSTRING_CURL_MACHINE; case ROMAN_CHAIR_APPARATUS;
    case GLUTE_PUSHBACK_MACHINE; case HACK_SQUAT_MACHINE; case LEG_EXTENSION_MACHINE;
    case LEG_PRESS_MACHINE; case SEATED_CALF_RAISE_MACHINE; case STANDING_CALF_RAISE_MACHINE; case STANDING_HAMSTRING_CURL_MACHINE;
    case ABDUCTION_MACHINE; case CRUNCH_MACHINE;
    
}
