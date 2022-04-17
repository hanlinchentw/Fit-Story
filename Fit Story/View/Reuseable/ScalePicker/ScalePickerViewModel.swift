//
//  ScalePickerViewModel.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/10.
//

import Foundation
import RxSwift
import RxCocoa

protocol ScalePickerViewModelType {
  associatedtype Inputs
  associatedtype Outputs
  var inputs: Inputs { get }
  var outputs: Outputs { get }
}
class ScalePickerViewModel: ScalePickerViewModelType {
  struct ScalePickerVMInputs {
    var userTypingInput: AnyObserver<Double>
    var userScrollingInput: AnyObserver<Int?>
    var isUserDragging: AnyObserver<Bool>
  }
  struct ScalePickerVMOutputs {
    var userTypinCorrespondingRow: Observable<Int?>
    var userScrollCorrespondingNumber: Observable<Double?>
  }

  typealias Inputs = ScalePickerVMInputs
  typealias Outputs = ScalePickerVMOutputs
  private(set) var inputs: Inputs
  private(set) var outputs: Outputs
  // Inputs
  var userTypingInput = PublishSubject<Double>()
  var userScrollingInput = PublishSubject<Int?>()
  var isUserDragging = BehaviorSubject<Bool>(value: false)
  init(dataSource: [Double]) {
    let userTypinCorrespondingRow = userTypingInput.map { (number) -> Int? in
      return dataSource.firstIndex(of: number)
      }
    let userScrollCorrespondingNumber = userScrollingInput.map { (row) -> Double? in
        guard let row = row else { return nil}
      return dataSource[row]
      }
    inputs = ScalePickerVMInputs(userTypingInput: userTypingInput.asObserver(),
                                 userScrollingInput: userScrollingInput.asObserver(),
                                 isUserDragging: isUserDragging.asObserver())
    outputs = ScalePickerVMOutputs(userTypinCorrespondingRow: userTypinCorrespondingRow, userScrollCorrespondingNumber: userScrollCorrespondingNumber)
  }
}
