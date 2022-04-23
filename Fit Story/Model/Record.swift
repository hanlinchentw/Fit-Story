//
//  Record.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/23.
//

import Foundation

enum OptionalRecord: String {
  case weight = "Weight"
  case bodyFat = "Body Fat"
  case calorieIntake = "Calorie Intake"
  case muscleMass = "Muscle Mass"
  case metabolism = "Basal Metabolism"
  case bustSize = "Bust Size"
  case waistSize = "Waist Size"
  case hipsSize = "Hips Size"
  case rightThighSize = "Right Thigh Size"
  case leftThighSize = "Left Thigh Size"
  case rightCalfSize = "Right Calf Size"
  case leftCalfSize = "Left Calf Size"
  case rightArmSize = "Right Arm Size"
  case leftArmSize = "Left Arm Size"

  var unit: String {
    switch self {
    case .weight: return "kg"
    case .bodyFat: return "%"
    case .calorieIntake: return "kcals"
    case .muscleMass: return "kg"
    case .metabolism: return "kcals"
    case .bustSize,
        .waistSize,
        .hipsSize,
        .rightThighSize,
        .leftThighSize,
        .rightCalfSize,
        .leftCalfSize,
        .rightArmSize,
        .leftArmSize:
      return "cm"
    }
  }
}

struct Record {

}
