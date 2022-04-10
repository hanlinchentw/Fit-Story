//
//  ScalePickerViewModel.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/10.
//

import Foundation

class ScalePickerViewModel {
  private let fakeDatasource: [Double] = (0...1000).map { Double($0)/10 }
  var cellVMs: [ScalePickerCellViewModel]
  init() {
    self.cellVMs = fakeDatasource.map {ScalePickerCellViewModel(scaleNumber: $0)}
  }
}
