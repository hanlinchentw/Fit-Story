//
//  ScalePickerViewModel.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/10.
//

import Foundation
import RxSwift
import RxCocoa

class ScalePickerViewModel {
  struct ScalePickerVMInputs {
    var dataSource: Observable<[Double]>
    var scaleNumber: Observable<Double>
  }

  var dataSourceInput: Observable<[Double]>
  var scaleNumberInput: Observable<Double>

  var currentRowOutput: Observable<Int?>
  init(inputs: ScalePickerVMInputs) {
    self.scaleNumberInput = inputs.scaleNumber
    self.dataSourceInput = inputs.dataSource

    self.currentRowOutput = Observable
      .combineLatest(scaleNumberInput, dataSourceInput) { (number, source) in
        source.firstIndex(of: number)
      }
  }
}
