//
//  ScalePicker.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/10.
//

import UIKit
import RxSwift
import RxCocoa

private let scalePickerID = "scalePickerID"
class ScalePicker: UICollectionView {
  let vm = ScalePickerViewModel()
  let bag = DisposeBag()

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: .zero, collectionViewLayout: layout)
    self.showsHorizontalScrollIndicator = false
    backgroundColor = .clear
    setUpBinding()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func setUpBinding() {
    self.register(ScalePickerCell.self, forCellWithReuseIdentifier: scalePickerID)
    Observable
      .just(vm.cellVMs)
      .bind(to: self.rx.items) { (collectionView, row, vm) in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scalePickerID, for: IndexPath(row: row, section: 0)) as? ScalePickerCell else {
          return UICollectionViewCell()
        }
        cell.setupBinding()
        cell.vm.accept(vm)
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)

        return cell
      }.disposed(by: bag)
  }
}
