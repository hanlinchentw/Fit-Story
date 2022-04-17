//
//  CreateRecordViewController.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/17.
//

import UIKit
import RxCocoa
import RxSwift

class CreateRecordViewController: UIViewController {
// MARK: - Properties
  private let bag = DisposeBag()
  private let selectedDateHeader = UIButton().createChakraButton(text: "Today", withWeight: .medium, withFont: .h6, withColor: .white)
// MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
}
// MARK: - UI
private extension CreateRecordViewController {
  private func setupUI() {
    setupNavBar()
    setupNavHeaderBtn()
    view.backgroundColor = .background1
  }
  private func setupNavBar() {
    let closeBarItem = UIBarButtonItem(image: UIImage.close, style: .plain, target: self, action: nil)
    closeBarItem.rx.tap
      .bind { _ in
      self.navigationController?.dismiss(animated: true, completion: nil)
    }.disposed(by: bag)
    navigationItem.rightBarButtonItem = closeBarItem
  }
  private func setupNavHeaderBtn() {
    guard let nav = self.navigationController else { return }
    nav.navigationBar.addSubview(selectedDateHeader)
    selectedDateHeader.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    selectedDateHeader.rx
      .tap
      .bind { [weak self] _ in
      let datePicker = DatePickerViewController()
      datePicker.modalPresentationStyle = .overFullScreen
      datePicker.modalTransitionStyle = .crossDissolve
      self?.present(datePicker, animated: true, completion: nil)
    }.disposed(by: bag)
  }
}
