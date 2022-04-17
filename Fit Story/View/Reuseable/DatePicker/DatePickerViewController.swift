//
//  DatePickerViewController.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/17.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
class DatePickerViewController: UIViewController {
  private let bag = DisposeBag()
// MARK: - Properties
  private let blackView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0, alpha: 0.6)
    return view
  }()
  private let datePickerContainer: UIView  = {
    let view = UIView()
    view.layer.cornerRadius = 8
    view.backgroundColor = .background2
    return view
  }()
  private let titleLabel = UILabel().createChakraLabel(text: "Jump to:", withWeight: .medium, withFont: .h5, withColor: .white)
  private let datePicker: UIDatePicker = {
    let picker = UIDatePicker()
    if #available(iOS 13.4, *) {
      picker.preferredDatePickerStyle = .wheels
    }
    picker.datePickerMode = .date
    picker.setValue(UIColor.white, forKey: "textColor")
    return picker
  }()
  private let cancelBtn = UIButton().createChakraButton(text: "Cancel", withWeight: .medium, withFont: .h6, withColor: .purple)
  private let doneBtn = UIButton().createChakraButton(text: "Done", withWeight: .medium, withFont: .h6, withColor: .purple)
// MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    tapBinding()
  }
// MARK: - Binding
  func tapBinding() {
    let tap = UITapGestureRecognizer()
    blackView.addGestureRecognizer(tap)
    tap.rx.event
      .bind { _ in
        self.dismiss(animated: true, completion: nil)
      }.disposed(by: bag)

    cancelBtn.rx.tap
      .bind { _ in
        self.dismiss(animated: true, completion: nil)
      }.disposed(by: bag)
  }
}
// MARK: - UI
extension DatePickerViewController {
  private func setupUI () {
    DispatchQueue.main.async {
      self.addBlackView()
      self.addDatePickerContainer()
      self.addTitleLabel()
      self.addDatePicker()
      self.addTwoHorizontalButton()
    }
  }
  private func addBlackView() {
    view.addSubview(blackView)
    blackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  private func addDatePickerContainer() {
    blackView.addSubview(datePickerContainer)
    datePickerContainer.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.height.equalTo(310)
      make.center.equalToSuperview()
    }
  }
  private func addTitleLabel() {
    datePickerContainer.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(16)
    }
  }
  private func addDatePicker() {
    datePickerContainer.addSubview(datePicker)
    datePicker.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }

  private func addTwoHorizontalButton() {
    let twoHorizontalButtonStackView = UIStackView(arrangedSubviews: [cancelBtn, doneBtn])
    twoHorizontalButtonStackView.axis = .horizontal
    twoHorizontalButtonStackView.distribution = .fillEqually
    datePickerContainer.addSubview(twoHorizontalButtonStackView)
    twoHorizontalButtonStackView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-16)
      make.left.equalToSuperview()
      make.right.equalToSuperview()
    }
  }
}
