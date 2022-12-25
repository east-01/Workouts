//
//  Exercise.swift
//  Workouts
//
//  Created by Ethan Mullen on 11/26/22.
//

import Foundation

enum Exercise: CaseIterable {
    
    case ALTERNATING_DUMBBELL_FRONT_RAISES; case ARNOLD_DUMBBELL_PRESS; case ASSISTED_PULL_UPS; case ASSISTED_REVERSE_CHIN_UPS; case ASSISTED_TRICEP_DIPS_MACHINE;
    case BACK_EXTENSIONS; case BARBELL_BENCH_PRESS; case BARBELL_DECLINE_BENCH_PRESS; case BARBELL_INCLINE_BENCH_PRESS; case BARBELL_BICEP_CURLS;
    case BARBELL_DEADLIFTS; case BARBELL_FRONT_SQUATS; case BARBELL_GOOD_MORNINGS; case BARBELL_LUNGES; case BARBELL_ROMANIAN_DEADLIFTS;
    case BARBELL_ROWS; case BARBELL_SHRUGS; case BARBELL_SQUAT; case BARBELL_SUMO_DEADLIFTS; case BARBELL_UPRIGHT_ROWS;
    case BEHIND_THE_NECK_BARBELL_OVERHEAD_PRESS; case BEHIND_THE_NECK_LAT_PULLDOWN; case BENT_OVER_CALF_RAISE_MACHINE; case BENT_OVER_DUMBBELL_ROWS; case BENT_OVER_DUMBBELL_TRICEP_KICKBACKS;
    case BENT_OVER_REAR_DELT_FLYS; case BODYWEIGHT_CALF_RAISES; case BOX_SQUATS; case CABLE_ABDUCTIONS; case CABLE_BENT_OVER_REAR_DELT_FLY;
    case INCLINE_CHEST_FLY; case CABLE_BICEP_CURLS; case CABLE_CROSSOVER_FLYS; case CABLE_CRUNCHES; case CABLE_EXTERNAL_SHOULDER_ROTATIONS;
    case CABLE_FRONT_RAISES_OVERHAND_GRIP; case CABLE_KICKBACKS; case CABLE_ROPE_FRONT_RAISES_NEUTRAL_GRIP; case CABLE_SIDE_RAISE; case CABLE_TRICEP_PUSHDOWNS;
    case CLOSE_GRIP_BENCH_PRESS; case CLOSE_GRIP_LAT_PULLDOWNS; case CRUNCHES; case DECLINE_BENCH_PRESS; case DECLINE_REVERSE_CRUNCHES;
    case DECLINE_SIT_UPS; case DONKEY_KICKS; case DUMBBELL_BENCH_PRESS; case DUMBBELL_DECLINE_BENCH; case DUMBBELL_INCLINE_BENCH;
    case DUMBBELL_BICEP_CURL; case DUMBBELL_CALF_RAISES; case DUMBBELL_DEADLIFTS; case DUMBBELL_FRONT_RAISES; case DUMBBELL_HAMMER_CURL;
    case DUMBBELL_LUNGES; case DUMBBELL_ROMANIAN_DEADLIFTS; case DUMBBELL_SHRUGS; case DUMBBELL_SIDE_BENDS; case DUMBBELL_SIDE_RAISES;
    case DUMBBELL_SQUATS; case DUMBBELL_SUMO_DEADLIFTS; case DUMBBELL_UPRIGHT_ROWS; case ELEVATED_CRUNCHES; case EZ_BAR_PREACHER_CURLS;
    case EZ_BAR_SKULL_CRUSHERS; case FLAT_LYING_DUMBBELL_FLYS; case GLUTE_BRIDGES; case HACK_SQUATS; case HAMMER_CURLS;
    case HANGING_CRUNCHES; case INCLINE_BARBELL_BENCH_PRESS; case INCLINE_DUMBBELL_BENCH_PRESS; case INCLINE_DUMBBELL_CURLS; case INCLINE_DUMBBELL_FLYS;
    case KNEE_PUSH_UPS; case LEG_EXTENSION_MACHINE; case LUNGES; case LYING_DUMBBELL_PULLOVERS; case LYING_DUMBBELL_TRICEP_EXTENSIONS;
    case LYING_HAMSTRING_CURL; case LYING_HIP_ABDUCTIONS; case MACHINE_ABDUCTIONS; case MACHINE_BICEP_CURLS; case MACHINE_CHEST_PRESS;
    case MACHINE_CRUNCHES; case MACHINE_LATERAL_SHOULDER_RAISES; case DUMBBELL_LATERAL_RAISE; case MINI_CRUNCHES; case PEC_DECK_FLYS;
    case PULL_UPS; case PUSH_UPS; case PUSHBACK_MACHINE; case REAR_DELT_FLY_MACHINE; case REVERSE_CHIN_UPS;
    case SEATED_BARBELL_OVERHEAD_PRESS; case SEATED_CABLE_ROWS; case SEATED_CALF_RAISE_MACHINE; case SEATED_DUMBBELL_OVERHEAD_PRESS; case SEATED_HAMSTRING_CURL;
    case SEATED_LEG_PRESS; case SEATED_OVERHEAD_DUMBBELL_TRICEPS_EXTENSIONS; case SINGLE_ARM_BENT_OVER_DUMBBELL_ROWS; case SINGLE_ARM_DUMBBELL_OVERHEAD_TRICEP_EXTENSIONS; case SIT_UPS;
    case STANDING_CALF_RAISE_MACHINE; case STANDING_SINGLE_LEG_HAMSTRING_CURL; case STRAIGHT_ARM_LAT_PULLDOWN; case SUMO_DUMBBELL_SQUATS; case T_BAR_ROWS;
    case TRAP_BAR_DEADLIFT; case TRICEP_DIPS; case TRICEP_DIPS_OFF_BENCH; case UPRIGHT_ROWS; case WIDE_GRIP_LAT_PULLDOWN;
    case WIDE_GRIP_SEATED_CABLE_ROWS;

      func data() -> ExerciseData {
          switch self {
          case .ALTERNATING_DUMBBELL_FRONT_RAISES:
              return ExerciseData("Alternating Dumbbell Front Raises")
                  .setMuscleGroups([.GEN_SHOULDERS, .FRONT_DELTS])
          case .ARNOLD_DUMBBELL_PRESS:
              return ExerciseData("Arnold Dumbbell Press")
                  .setMuscleGroups([.GEN_SHOULDERS, .FRONT_DELTS, .GEN_TRICEP])
          case .ASSISTED_PULL_UPS:
              return ExerciseData("Assisted Pull-Ups")
                  .setMuscleGroups([.LATS, .GEN_BICEP])
          case .ASSISTED_REVERSE_CHIN_UPS:
              return ExerciseData("Assisted Reverse Chin-Ups")
                  .setMuscleGroups([.LATS, .GEN_BICEP])
          case .ASSISTED_TRICEP_DIPS_MACHINE:
              return ExerciseData("Assisted Tricep Dips Machine")
                  .setMuscleGroups([.GEN_TRICEP])
          case .BACK_EXTENSIONS:
              return ExerciseData("Back Extensions")
                  .setMuscleGroups([.HAMSTRING, .LOWER_BACK])
          case .BARBELL_BENCH_PRESS:
              return ExerciseData("Barbell Bench Press")
                  .setMuscleGroups([.GEN_CHEST, .GEN_TRICEP, .FRONT_DELTS])
          case .BARBELL_DECLINE_BENCH_PRESS:
              return ExerciseData("Barbell Decline Bench Press")
                  .setMuscleGroups([.LOWER_CHEST])
          case .BARBELL_INCLINE_BENCH_PRESS:
              return ExerciseData("Barbell Incline Bench Press")
                  .setMuscleGroups([.UPPER_CHEST])
          case .BARBELL_BICEP_CURLS:
              return ExerciseData("Barbell Bicep Curls")
                  .setMuscleGroups([.GEN_BICEP])
          case .BARBELL_DEADLIFTS:
              return ExerciseData("Barbell Deadlifts")
                  .setMuscleGroups([.GLUTES, .HAMSTRING])
          case .BARBELL_FRONT_SQUATS:
              return ExerciseData("Barbell Front Squats")
                  .setMuscleGroups([.QUADS])
          case .BARBELL_GOOD_MORNINGS:
              return ExerciseData("Barbell Good Mornings")
                  .setMuscleGroups([.LOWER_BACK, .GLUTES, .HAMSTRING])
          case .BARBELL_LUNGES:
              return ExerciseData("Barbell Lunges")
                  .setMuscleGroups([.QUADS, .GLUTES, .HAMSTRING])
          case .BARBELL_ROMANIAN_DEADLIFTS:
              return ExerciseData("Barbell Romanian Deadlifts")
                  .setMuscleGroups([.GLUTES, .HAMSTRING])
          case .BARBELL_ROWS:
              return ExerciseData("Barbell Rows")
                  .setMuscleGroups([.LATS, .REAR_DELTS, .GEN_BICEP, .TRAPS])
          case .BARBELL_SHRUGS:
              return ExerciseData("Barbell Shrugs")
                  .setMuscleGroups([.TRAPS])
          case .BARBELL_SQUAT:
              return ExerciseData("Barbell Squat")
                  .setMuscleGroups([.QUADS, .GLUTES])
          case .BARBELL_SUMO_DEADLIFTS:
              return ExerciseData("Barbell Sumo Deadlifts")
                  .setMuscleGroups([.GLUTES, .HAMSTRING])
          case .BARBELL_UPRIGHT_ROWS:
              return ExerciseData("Barbell Upright Rows")
                  .setMuscleGroups([.GEN_SHOULDERS, .MIDDLE_DELTS, .TRAPS, .GEN_BICEP])
          case .BEHIND_THE_NECK_BARBELL_OVERHEAD_PRESS:
              return ExerciseData("Behind the Neck Barbell Overhead Press")
                  .setMuscleGroups([.GEN_SHOULDERS, .GEN_SHOULDERS])
          case .BEHIND_THE_NECK_LAT_PULLDOWN:
              return ExerciseData("Behind the Neck Lat Pulldown")
                  .setMuscleGroups([.LATS, .GEN_BICEP])
          case .BENT_OVER_CALF_RAISE_MACHINE:
              return ExerciseData("Bent-Over Calf Raise Machine")
                  .setMuscleGroups([.CALVES])
          case .BENT_OVER_DUMBBELL_ROWS:
              return ExerciseData("Bent-Over Dumbbell Rows")
                  .setMuscleGroups([.LATS, .REAR_DELTS, .GEN_BICEP, .TRAPS])
          case .BENT_OVER_DUMBBELL_TRICEP_KICKBACKS:
              return ExerciseData("Bent-Over Dumbbell Tricep Kickbacks")
                  .setMuscleGroups([.GEN_TRICEP])
          case .BENT_OVER_REAR_DELT_FLYS:
              return ExerciseData("Bent-Over Rear Delt Flys")
                  .setMuscleGroups([.GEN_SHOULDERS, .REAR_DELTS, .TRAPS])
          case .BODYWEIGHT_CALF_RAISES:
              return ExerciseData("Bodyweight Calf Raises")
                  .setMuscleGroups([.CALVES])
          case .BOX_SQUATS:
              return ExerciseData("Box Squats")
                  .setMuscleGroups([.QUADS, .GLUTES, .HAMSTRING])
          case .CABLE_ABDUCTIONS:
              return ExerciseData("Cable Abductions")
                  .setMuscleGroups([.GLUTES])
          case .CABLE_BENT_OVER_REAR_DELT_FLY:
              return ExerciseData("Cable Bent-Over Rear Delt Fly")
                  .setMuscleGroups([.GEN_SHOULDERS, .REAR_DELTS])
          case .INCLINE_CHEST_FLY:
              return ExerciseData("Incline Chest Fly")
                  .setMuscleGroups([.GEN_CHEST, .GEN_SHOULDERS, .GEN_TRICEP])
          case .CABLE_BICEP_CURLS:
              return ExerciseData("Cable Bicep Curls")
                  .setMuscleGroups([.GEN_BICEP])
          case .CABLE_CROSSOVER_FLYS:
              return ExerciseData("Cable Crossover Flys")
                  .setMuscleGroups([.GEN_CHEST])
          case .CABLE_CRUNCHES:
              return ExerciseData("Cable Crunches")
                  .setMuscleGroups([.GEN_ABS])
          case .CABLE_EXTERNAL_SHOULDER_ROTATIONS:
              return ExerciseData("Cable External Shoulder Rotations")
                  .setMuscleGroups([.GEN_SHOULDERS, .ROTATOR_CUFF, .REAR_DELTS])
          case .CABLE_FRONT_RAISES_OVERHAND_GRIP:
              return ExerciseData("Cable Front Raises (Overhand Grip)")
                  .setMuscleGroups([.GEN_SHOULDERS, .FRONT_DELTS])
          case .CABLE_KICKBACKS:
              return ExerciseData("Cable Kickbacks")
                  .setMuscleGroups([.GLUTES])
          case .CABLE_ROPE_FRONT_RAISES_NEUTRAL_GRIP:
              return ExerciseData("Cable Rope Front Raises (Neutral Grip)")
                  .setMuscleGroups([.GEN_SHOULDERS, .FRONT_DELTS])
          case .CABLE_SIDE_RAISE:
              return ExerciseData("Cable Side Raise")
                  .setMuscleGroups([.GEN_SHOULDERS, .MIDDLE_DELTS])
          case .CABLE_TRICEP_PUSHDOWNS:
              return ExerciseData("Cable Tricep Pushdowns")
                  .setMuscleGroups([.GEN_TRICEP])
          case .CLOSE_GRIP_BENCH_PRESS:
              return ExerciseData("Close Grip Bench Press")
                  .setMuscleGroups([.GEN_CHEST, .GEN_TRICEP, .FRONT_DELTS])
          case .CLOSE_GRIP_LAT_PULLDOWNS:
              return ExerciseData("Close Grip Lat Pulldowns")
                  .setMuscleGroups([.LATS, .GEN_BICEP])
          case .CRUNCHES:
              return ExerciseData("Crunches")
                  .setMuscleGroups([.GEN_ABS])
          case .DECLINE_BENCH_PRESS:
              return ExerciseData("Decline Bench Press")
                  .setMuscleGroups([.GEN_CHEST, .GEN_TRICEP, .FRONT_DELTS])
          case .DECLINE_REVERSE_CRUNCHES:
              return ExerciseData("Decline Reverse Crunches")
                  .setMuscleGroups([.GEN_ABS])
          case .DECLINE_SIT_UPS:
              return ExerciseData("Decline Sit-Ups")
                  .setMuscleGroups([.GEN_ABS])
          case .DONKEY_KICKS:
              return ExerciseData("Donkey Kicks")
                  .setMuscleGroups([.GLUTES])
          case .DUMBBELL_BENCH_PRESS:
              return ExerciseData("Dumbbell Bench Press")
                  .setMuscleGroups([.GEN_CHEST, .GEN_TRICEP, .FRONT_DELTS])
          case .DUMBBELL_DECLINE_BENCH:
              return ExerciseData("Dumbbell Decline Bench")
                  .setMuscleGroups([.LOWER_CHEST])
          case .DUMBBELL_INCLINE_BENCH:
              return ExerciseData("Dumbbell Incline Bench")
                  .setMuscleGroups([.UPPER_CHEST])
          case .DUMBBELL_BICEP_CURL:
              return ExerciseData("Dumbbell Bicep Curl")
                  .setMuscleGroups([.GEN_BICEP, .FRONT_DELTS])
          case .DUMBBELL_CALF_RAISES:
              return ExerciseData("Dumbbell Calf Raises")
                  .setMuscleGroups([.CALVES])
          case .DUMBBELL_DEADLIFTS:
              return ExerciseData("Dumbbell Deadlifts")
                  .setMuscleGroups([.GLUTES, .HAMSTRING])
          case .DUMBBELL_FRONT_RAISES:
              return ExerciseData("Dumbbell Front Raises")
                  .setMuscleGroups([.GEN_SHOULDERS, .FRONT_DELTS])
          case .DUMBBELL_HAMMER_CURL:
              return ExerciseData("Dumbbell Hammer Curl")
                  .setMuscleGroups([.GEN_BICEP])
          case .DUMBBELL_LUNGES:
              return ExerciseData("Dumbbell Lunges")
                  .setMuscleGroups([.QUADS, .GLUTES, .HAMSTRING])
          case .DUMBBELL_ROMANIAN_DEADLIFTS:
              return ExerciseData("Dumbbell Romanian Deadlifts")
                  .setMuscleGroups([.GLUTES, .HAMSTRING])
          case .DUMBBELL_SHRUGS:
              return ExerciseData("Dumbbell Shrugs")
                  .setMuscleGroups([.TRAPS])
          case .DUMBBELL_SIDE_BENDS:
              return ExerciseData("Dumbbell Side Bends")
                  .setMuscleGroups([.GEN_ABS])
          case .DUMBBELL_SIDE_RAISES:
              return ExerciseData("Dumbbell Side Raises")
                  .setMuscleGroups([.GEN_SHOULDERS, .MIDDLE_DELTS])
          case .DUMBBELL_SQUATS:
              return ExerciseData("Dumbbell Squats")
                  .setMuscleGroups([.QUADS, .GLUTES])
          case .DUMBBELL_SUMO_DEADLIFTS:
              return ExerciseData("Dumbbell Sumo Deadlifts")
                  .setMuscleGroups([.GLUTES, .HAMSTRING])
          case .DUMBBELL_UPRIGHT_ROWS:
              return ExerciseData("Dumbbell Upright Rows")
                  .setMuscleGroups([.GEN_SHOULDERS, .MIDDLE_DELTS, .TRAPS, .GEN_BICEP])
          case .ELEVATED_CRUNCHES:
              return ExerciseData("Elevated Crunches")
                  .setMuscleGroups([.GEN_ABS])
          case .EZ_BAR_PREACHER_CURLS:
              return ExerciseData("EZ Bar Preacher Curls")
                  .setMuscleGroups([.GEN_BICEP])
          case .EZ_BAR_SKULL_CRUSHERS:
              return ExerciseData("EZ Bar Skull Crushers")
                  .setMuscleGroups([.GEN_TRICEP])
          case .FLAT_LYING_DUMBBELL_FLYS:
              return ExerciseData("Flat Lying Dumbbell Flys")
                  .setMuscleGroups([.GEN_CHEST])
          case .GLUTE_BRIDGES:
              return ExerciseData("Glute Bridges")
                  .setMuscleGroups([.GLUTES])
          case .HACK_SQUATS:
              return ExerciseData("Hack Squats")
                  .setMuscleGroups([.QUADS, .GLUTES, .HAMSTRING])
          case .HAMMER_CURLS:
              return ExerciseData("Hammer Curls")
                  .setMuscleGroups([.GEN_BICEP])
          case .HANGING_CRUNCHES:
              return ExerciseData("Hanging Crunches")
                  .setMuscleGroups([.GEN_ABS])
          case .INCLINE_BARBELL_BENCH_PRESS:
              return ExerciseData("Incline Barbell Bench Press")
                  .setMuscleGroups([.GEN_CHEST, .GEN_TRICEP, .FRONT_DELTS])
          case .INCLINE_DUMBBELL_BENCH_PRESS:
              return ExerciseData("Incline Dumbbell Bench Press")
                  .setMuscleGroups([.GEN_CHEST, .GEN_TRICEP, .FRONT_DELTS])
          case .INCLINE_DUMBBELL_CURLS:
              return ExerciseData("Incline Dumbbell Curls")
                  .setMuscleGroups([.GEN_BICEP])
          case .INCLINE_DUMBBELL_FLYS:
              return ExerciseData("Incline Dumbbell Flys")
                  .setMuscleGroups([.GEN_CHEST])
          case .KNEE_PUSH_UPS:
              return ExerciseData("Knee Push-Ups")
                  .setMuscleGroups([.GEN_CHEST, .GEN_TRICEP, .FRONT_DELTS])
          case .LEG_EXTENSION_MACHINE:
              return ExerciseData("Leg Extension Machine")
                  .setMuscleGroups([.QUADS])
          case .LUNGES:
              return ExerciseData("Lunges")
                  .setMuscleGroups([.QUADS, .GLUTES, .HAMSTRING])
          case .LYING_DUMBBELL_PULLOVERS:
              return ExerciseData("Lying Dumbbell Pullovers")
                  .setMuscleGroups([.GEN_CHEST, .LATS, .GEN_ABS])
          case .LYING_DUMBBELL_TRICEP_EXTENSIONS:
              return ExerciseData("Lying Dumbbell Tricep Extensions")
                  .setMuscleGroups([.GEN_TRICEP])
          case .LYING_HAMSTRING_CURL:
              return ExerciseData("Lying Hamstring Curl")
                  .setMuscleGroups([.HAMSTRING])
          case .LYING_HIP_ABDUCTIONS:
              return ExerciseData("Lying Hip Abductions")
                  .setMuscleGroups([.GLUTES])
          case .MACHINE_ABDUCTIONS:
              return ExerciseData("Machine Abductions")
                  .setMuscleGroups([.GLUTES])
          case .MACHINE_BICEP_CURLS:
              return ExerciseData("Machine Bicep Curls")
                  .setMuscleGroups([.GEN_BICEP])
          case .MACHINE_CHEST_PRESS:
              return ExerciseData("Machine Chest Press")
                  .setMuscleGroups([.GEN_CHEST, .GEN_TRICEP, .FRONT_DELTS])
          case .MACHINE_CRUNCHES:
              return ExerciseData("Machine Crunches")
                  .setMuscleGroups([.GEN_ABS])
          case .MACHINE_LATERAL_SHOULDER_RAISES:
              return ExerciseData("Machine Lateral Shoulder Raises")
                  .setMuscleGroups([.GEN_SHOULDERS, .GEN_SHOULDERS])
          case .DUMBBELL_LATERAL_RAISE:
              return ExerciseData("Dumbbell Lateral Raise")
                  .setMuscleGroups([.GEN_SHOULDERS])
          case .MINI_CRUNCHES:
              return ExerciseData("Mini Crunches")
                  .setMuscleGroups([.GEN_ABS])
          case .PEC_DECK_FLYS:
              return ExerciseData("Pec Deck Flys")
                  .setMuscleGroups([.GEN_CHEST])
          case .PULL_UPS:
              return ExerciseData("Pull-Ups")
                  .setMuscleGroups([.LATS, .GEN_BICEP])
          case .PUSH_UPS:
              return ExerciseData("Push-Ups")
                  .setMuscleGroups([.GEN_CHEST, .GEN_TRICEP, .FRONT_DELTS])
          case .PUSHBACK_MACHINE:
              return ExerciseData("Pushback Machine")
                  .setMuscleGroups([.GLUTES])
          case .REAR_DELT_FLY_MACHINE:
              return ExerciseData("Rear Delt Fly Machine")
                  .setMuscleGroups([.GEN_SHOULDERS, .REAR_DELTS])
          case .REVERSE_CHIN_UPS:
              return ExerciseData("Reverse Chin-Ups")
                  .setMuscleGroups([.LATS, .GEN_BICEP])
          case .SEATED_BARBELL_OVERHEAD_PRESS:
              return ExerciseData("Seated Barbell Overhead Press")
                  .setMuscleGroups([.GEN_SHOULDERS, .GEN_SHOULDERS, .GEN_TRICEP, .TRAPS])
          case .SEATED_CABLE_ROWS:
              return ExerciseData("Seated Cable Rows")
                  .setMuscleGroups([.LATS, .REAR_DELTS, .GEN_BICEP, .TRAPS])
          case .SEATED_CALF_RAISE_MACHINE:
              return ExerciseData("Seated Calf Raise Machine")
                  .setMuscleGroups([.CALVES])
          case .SEATED_DUMBBELL_OVERHEAD_PRESS:
              return ExerciseData("Seated Dumbbell Overhead Press")
                  .setMuscleGroups([.GEN_SHOULDERS, .MIDDLE_DELTS, .TRAPS, .GEN_TRICEP])
          case .SEATED_HAMSTRING_CURL:
              return ExerciseData("Seated Hamstring Curl")
                  .setMuscleGroups([.HAMSTRING])
          case .SEATED_LEG_PRESS:
              return ExerciseData("Seated Leg Press")
                  .setMuscleGroups([.QUADS, .GLUTES, .HAMSTRING])
          case .SEATED_OVERHEAD_DUMBBELL_TRICEPS_EXTENSIONS:
              return ExerciseData("Seated Overhead Dumbbell Triceps Extensions")
                  .setMuscleGroups([.GEN_TRICEP])
          case .SINGLE_ARM_BENT_OVER_DUMBBELL_ROWS:
              return ExerciseData("Single-Arm Bent-Over Dumbbell Rows")
                  .setMuscleGroups([.LATS, .REAR_DELTS, .GEN_BICEP, .TRAPS])
          case .SINGLE_ARM_DUMBBELL_OVERHEAD_TRICEP_EXTENSIONS:
              return ExerciseData("Single-Arm Dumbbell Overhead Tricep Extensions")
                  .setMuscleGroups([.GEN_TRICEP])
          case .SIT_UPS:
              return ExerciseData("Sit-Ups")
                  .setMuscleGroups([.GEN_ABS])
          case .STANDING_CALF_RAISE_MACHINE:
              return ExerciseData("Standing Calf Raise Machine")
                  .setMuscleGroups([.CALVES])
          case .STANDING_SINGLE_LEG_HAMSTRING_CURL:
              return ExerciseData("Standing Single-Leg Hamstring Curl")
                  .setMuscleGroups([.HAMSTRING])
          case .STRAIGHT_ARM_LAT_PULLDOWN:
              return ExerciseData("Straight Arm Lat Pulldown")
                  .setMuscleGroups([.LATS])
          case .SUMO_DUMBBELL_SQUATS:
              return ExerciseData("Sumo Dumbbell Squats")
                  .setMuscleGroups([.QUADS, .GLUTES, .HAMSTRING])
          case .T_BAR_ROWS:
              return ExerciseData("T-Bar Rows")
                  .setMuscleGroups([.LATS, .REAR_DELTS, .GEN_BICEP, .TRAPS])
          case .TRAP_BAR_DEADLIFT:
              return ExerciseData("Trap Bar Deadlift")
                  .setMuscleGroups([.QUADS, .HAMSTRING])
          case .TRICEP_DIPS:
              return ExerciseData("Tricep Dips")
                  .setMuscleGroups([.GEN_TRICEP])
          case .TRICEP_DIPS_OFF_BENCH:
              return ExerciseData("Tricep Dips Off Bench")
                  .setMuscleGroups([.GEN_TRICEP])
          case .UPRIGHT_ROWS:
              return ExerciseData("Upright Rows")
                  .setMuscleGroups([.MIDDLE_DELTS, .REAR_DELTS, .TRAPS, .MID_BACK])
          case .WIDE_GRIP_LAT_PULLDOWN:
              return ExerciseData("Wide Grip Lat Pulldown")
                  .setMuscleGroups([.LATS, .GEN_BICEP])
          case .WIDE_GRIP_SEATED_CABLE_ROWS:
              return ExerciseData("Wide Grip Seated Cable Rows")
                  .setMuscleGroups([.LATS, .REAR_DELTS, .GEN_BICEP, .TRAPS])
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
