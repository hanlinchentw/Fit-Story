//
//  ScalePickerContainer.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ScalePickerContainer: UIView {
// MARK: - Properties
  // Rx
  let fakeDatasource: Observable<[Double]> = Observable.just((0...1000).map { Double($0)/10 })
  var scaleNumber = BehaviorSubject<Double>(value: 0.0)
  private let bag = DisposeBag()
  // UI
  private var scalePicker: ScalePicker
  private let middleBarImageView: UIImageView = {
    let iv = UIImageView(image: UIImage.middleBar)
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  private var displayScaleLabel: UILabel = {
    let label = UILabel()
    label.text = "10"
    label.textColor = .darkGreen
    label.font = UIFont.semiBoldChakra(of: UIFont.H4)
    return label
  }()
// MARK: - Lifecycle
  override init(frame: CGRect) {
    scalePicker = ScalePicker(vm: ScalePickerViewModel(inputs: .init(dataSource: fakeDatasource, scaleNumber: scaleNumber.asObservable())))
    super.init(frame: frame)
    addSubview(scalePicker)
    scalePicker.snp.makeConstraints { make in
      make.left.equalToSuperview()
      make.bottom.equalToSuperview()
      make.top.equalToSuperview()
      make.right.greaterThanOrEqualToSuperview()
    }
    addSubview(middleBarImageView)
    middleBarImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(-16)
    }
    addSubview(displayScaleLabel)
    displayScaleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(middleBarImageView.snp.top).offset(-8)
    }
    binding()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
// MARK: - Binding
  func binding() {
    scaleNumber
      .map({String($0)})
      .bind(to: displayScaleLabel.rx.text)
      .disposed(by: bag)
  }
}
