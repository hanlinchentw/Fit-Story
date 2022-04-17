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

let fakeDatasource: [Double] = (0...1000).map { Double($0)/10 }
class ScalePickerContainer: UIView {
// MARK: - Properties
  // Rx
  var scaleNumber = PublishSubject<Double>()
  var scrollInput: Observable<Double?>
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
    label.textColor = .darkGreen
    label.font = UIFont.semiBoldChakra(of: .h4)
    return label
  }()
// MARK: - Lifecycle
  override init(frame: CGRect) {
    scalePicker = ScalePicker(dataSource: fakeDatasource, userTypingValue: scaleNumber.asObservable())
    scrollInput = scalePicker.vm.outputs.userScrollCorrespondingNumber
    super.init(frame: .zero)
    setupUI()
    binding()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    scalePicker.contentInset = UIEdgeInsets(top: 0, left: self.frame.width/2 - 7, bottom: 0, right: self.frame.width/2 - 7)
  }
// MARK: - Binding
  func binding() {
    scaleNumber
      .map({String($0)})
      .bind(to: displayScaleLabel.rx.text)
      .disposed(by: bag)
    scrollInput
      .filter({$0 != nil})
      .map({String($0!)})
      .bind(to: displayScaleLabel.rx.text)
      .disposed(by: bag)
  }
}
// MARK: - UI
extension ScalePickerContainer {
  func setupUI() {
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
  }
}
