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
  let dateHeader = UIButton().createChakraButton(text: "Today",
                                                         withWeight: .medium,
                                                         withFont: .h6,
                                                         withColor: .white)
  let saveButton = UIButton().createChakraButton(text: "Save", withWeight: .medium, withFont: .h6, withColor: .white)
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBinding()
  }
}
// MARK: - Binding
private extension CreateRecordViewController {
  private func setupBinding() {
    setupDateHeaderBinding()
    setupSaveButtonBinding()
  }

  private func setupDateHeaderBinding() {
    dateHeader.rx.tap
      .bind { _ in
        PresentationHelper.shared.presentDatePickerViewController()
      }.disposed(by: bag)
  }

  private func setupSaveButtonBinding() {

  }
}
// MARK: - UI
extension CreateRecordViewController {
  func setupUI() {
    setupNavBar()
    setupNavHeaderBtn()
    setupSaveButton()
    setupRecordCollectionView()
    view.backgroundColor = .background1
  }

  private func setupNavBar() {
    let closeButton = UIBarButtonItem().closeButton
    closeButton.rx.tap
      .bind { _ in
        self.navigationController?.dismiss(animated: true, completion: nil)
      }.disposed(by: bag)
    navigationItem.rightBarButtonItem = closeButton
  }

  private func setupNavHeaderBtn() {
    guard let nav = self.navigationController else { return }
    nav.navigationBar.addSubview(dateHeader)
    dateHeader.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }

  private func setupRecordCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionVC = RecordCollectionViewController()
    self.addChild(collectionVC)
    self.view.addSubview(collectionVC.view)
    collectionVC.view.snp.makeConstraints { make in
      make.top.equalTo(self.view.snp.topMargin)
      make.bottom.equalTo(saveButton.snp.top).offset(-16)
      make.left.equalToSuperview()
      make.right.equalToSuperview()
    }
  }

  private func setupSaveButton() {
    view.addSubview(saveButton)
    saveButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-42)
      make.width.equalTo(335)
      make.height.equalTo(48)
    }
    saveButton.applyGradient(colors: [.lightPurple, .darkPurple])
  }
}
