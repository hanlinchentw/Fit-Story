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
  private let bag = DisposeBag()
  private let selectedDateHeader: UIView = {
    let view = UIView()
    let label = UILabel().createChakraLabel(text: "Today", withWeight: .medium, withFont: .h6, withColor: .white)
    view.addSubview(label)
    label.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    return view
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavBar()
    setupNavHeaderBtn()
    view.backgroundColor = .background1
  }

  func setupNavBar() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.close, style: .plain, target: self, action: #selector(handleCloseBtnTapped))
  }
  func setupNavHeaderBtn() {
    guard let nav = self.navigationController else { return }
    nav.navigationBar.addSubview(selectedDateHeader)
    selectedDateHeader.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    let tap = UITapGestureRecognizer()
    selectedDateHeader.addGestureRecognizer(tap)
    tap.rx.event.bind { [weak self] _ in
      let datePicker = DatePickerViewController()
      datePicker.modalPresentationStyle = .overFullScreen
      datePicker.modalTransitionStyle = .crossDissolve
      self?.present(datePicker, animated: true, completion: nil)
    }.disposed(by: bag)
  }
  @objc func handleCloseBtnTapped() {
    self.navigationController?.dismiss(animated: true, completion: nil)
  }
}
