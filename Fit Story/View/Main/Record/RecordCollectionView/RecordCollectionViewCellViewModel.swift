//
//  RecordCollectionViewCellViewModel.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/23.
//

import Foundation
import RxSwift
final class RecordCollectionViewCellViewModel {
  let recordInput = PublishSubject<OptionalRecord>()
  let titleOutput: Observable<String>
  let unitOutput: Observable<String>
  init() {
    self.titleOutput = recordInput.map({$0.rawValue})
    self.unitOutput = recordInput.map({$0.unit})
  }
}
