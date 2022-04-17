//
//  ScalePickerCellViewModel.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/10.
//

import UIKit

class ScalePickerCellViewModel {
  let scaleNumber:  Double
  init(scaleNumber: Double) {
    self.scaleNumber = scaleNumber
  }
  var scaleHeight: CGFloat {
    return isPrimary ? 24 : 16
  }

  var isPrimary: Bool {
    return  scaleNumber.truncatingRemainder(dividingBy: 1) == 0
  }

  var displayScaleString: String? {
    return isPrimary ? "\(Int(scaleNumber))" : nil
  }

  var cellZPosition: CGFloat {
    return isPrimary ? 2 : 1
  }
}
