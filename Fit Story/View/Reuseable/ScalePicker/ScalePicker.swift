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
  let userTypingValue: Observable<Double>
  var userScrollingCenterRow = PublishSubject<Int?>()
  var isUserDragging = BehaviorSubject<Bool>(value: false)
  let bag = DisposeBag()
  // MARK: - Lifecycle
  init(dataSource: [Double], userTypingValue: Observable<Double>) {
    self.vm = ScalePickerViewModel(dataSource: dataSource)
    self.userTypingValue = userTypingValue
    super.init(frame: .zero, collectionViewLayout: .init())
    collectionViewLayout = self.layoutForCollectionView()
    showsHorizontalScrollIndicator = false
    self.register(ScalePickerCell.self, forCellWithReuseIdentifier: scalePickerID)
    backgroundColor = .clear

    setUpCollectionView(with: dataSource)
    setUpDragStateChanged()
    setUpTextFieldStateChanged()
    setUpInput()
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
  func setUpInput() {
    userTypingValue.bind(to: vm.inputs.userTypingInput).disposed(by: bag)
    userScrollingCenterRow.bind(to: vm.userScrollingInput).disposed(by: bag)
    isUserDragging.bind(to: vm.isUserDragging).disposed(by: bag)
  }
  func setUpCollectionView(with dataSource: [Double]) {
    Observable.just(dataSource)
      .bind(to: self.rx.items) { (collectionView, row, scale) in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scalePickerID, for: IndexPath(row: row, section: 0))
        guard let cell = cell as? ScalePickerCell else {
          return UICollectionViewCell()
        }
        cell.setupBinding()
        cell.vm.accept(.init(scaleNumber: scale))
        return cell
      }.disposed(by: bag)
  }
  func setUpTextFieldStateChanged() {
    vm.outputs.userTypinCorrespondingRow
      .asDriver(onErrorJustReturn: nil)
      .distinctUntilChanged()
      .drive { optionRow in
        if let row = optionRow {
          let indexPath = IndexPath(row: row, section: 0)
          self.scrollToItem(at: indexPath, at: [], animated: true)
        }
      }.disposed(by: bag)
  }
  func setUpDragStateChanged() {
    self.rx.contentOffset
      .withLatestFrom(isUserDragging) { offset, isDragging -> Int? in
        if (!isDragging) {return nil} // 如果是程式控制的滑動，就不更新狀態
        let centerPoint = CGPoint(x:self.center.x + offset.x, y: self.center.y)
        return self.indexPathForItem(at: centerPoint)?.row
      }
      .asDriver(onErrorJustReturn: nil)
      .drive(self.userScrollingCenterRow)
      .disposed(by: bag)
    self.rx.willBeginDragging // 使用者用手指操作
      .map({true})
      .bind(to: self.isUserDragging)
      .disposed(by: bag)
    self.rx.didEndDecelerating
      .map({ _ -> Bool in return false})
      .bind(to: self.isUserDragging)
      .disposed(by: bag)
  }
}
