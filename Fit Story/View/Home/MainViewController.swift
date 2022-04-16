//
//  MainViewController.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/9.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
  private let bag = DisposeBag()
  private let scalePickerContainer = ScalePickerContainer()
  private let textInput: UITextField = {
    let tf = UITextField()
    tf.placeholder = "0.0"
    tf.textColor = .white
    tf.layer.cornerRadius = 12
    tf.layer.borderWidth = 1
    tf.layer.borderColor  = UIColor.white.cgColor
    return tf
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    view.addSubview(scalePickerContainer)
    scalePickerContainer.snp.makeConstraints { make in
      make.center.equalTo(self.view)
      make.width.equalTo(self.view.frame.width)
      make.height.equalTo(92)
    }
    view.addSubview(textInput)
    textInput.snp.makeConstraints { make in
      make.bottom.equalTo(scalePickerContainer.snp.top).offset(-150)
      make.width.equalTo(200)
      make.height.equalTo(72)
      make.centerX.equalToSuperview()
    }
    textInput.rx.controlEvent(.allEditingEvents)
      .filter { self.textInput.text != nil && self.textInput.text?.isEmpty == false }
      .map({ _ in
        guard let text = self.textInput.text,
                let textNumber = Double(text) else { return Double() }
        return Double(textNumber)
      })
      .distinctUntilChanged()
      .bind(to: scalePickerContainer.scaleNumber)
      .disposed(by: bag)
    scalePickerContainer.scrollInput
      .filter { $0 != nil }
      .map({String($0!)})
      .distinctUntilChanged()
      .bind(to: textInput.rx.text)
      .disposed(by: bag)
  }
}
