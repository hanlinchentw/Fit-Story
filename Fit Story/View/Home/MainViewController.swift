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
  private let scalePickerContainer = ScalePickerContainer()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    view.addSubview(scalePickerContainer)
    scalePickerContainer.snp.makeConstraints { make in
      make.center.equalTo(self.view)
      make.width.equalTo(self.view.frame.width)
      make.height.equalTo(92)
    }
  }
}
