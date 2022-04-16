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
    tf.text = "1"
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
      make.bottom.equalTo(scalePickerContainer.snp.top)
      make.width.equalTo(200)
      make.height.equalTo(72)
    }
    textInput.rx.text
      .orEmpty
      .map({ Double($0)! })
      .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
      .bind(to: scalePickerContainer.scaleNumber)

      .disposed(by: bag)
  }
}
