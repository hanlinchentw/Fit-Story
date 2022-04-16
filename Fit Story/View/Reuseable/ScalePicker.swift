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
// MARK: - Properties
  // Rx
  var vm: ScalePickerViewModel
  let bag = DisposeBag()
  public var currentScale = PublishSubject<CGFloat>()
// MARK: - Lifecycle
  init(vm: ScalePickerViewModel) {
    self.vm = vm
    super.init(frame: .zero, collectionViewLayout: .init())
    collectionViewLayout = self.layoutForCollectionView()
    showsHorizontalScrollIndicator = false
    self.register(ScalePickerCell.self, forCellWithReuseIdentifier: scalePickerID)
    backgroundColor = .clear
    setUpBinding()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func layoutForCollectionView() -> UICollectionViewFlowLayout {
    let customLayout = UICollectionViewFlowLayout()
    customLayout.scrollDirection = .horizontal
    customLayout.itemSize = CGSize(width: 16, height: 48)
    customLayout.minimumLineSpacing = -5
    return customLayout
  }
// MARK: - Binding
  func setUpBinding() {
    vm.dataSourceInput
      .bind(to: self.rx.items) { (collectionView, row, scale) in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scalePickerID, for: IndexPath(row: row, section: 0))
        guard let cell = cell as? ScalePickerCell else {
          return UICollectionViewCell()
        }
        cell.setupBinding()
        cell.vm.accept(.init(scaleNumber: scale))
//        let visibleRect = CGRect(origin: offset, size: self.bounds.size)
//        let visibleCenter = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
//        if let visibleIndexPath = self.indexPathForItem(at: visibleCenter) {
//          return source[visibleIndexPath.row]
//        }
        return cell
      }.disposed(by: bag)
    vm.currentRowOutput
      .asDriver(onErrorJustReturn: nil)
      .drive { optionRow in
        if let row = optionRow {
          print("Row: \(row)")
          let indexPath = IndexPath(row: row, section: 0)
          self.scrollToItem(at: indexPath, at: [], animated: true)
        }
    }.disposed(by: bag)
  }
}
