//
//  MainViewController.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/9.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
  private let hexBtn: HexButton = {
    let btn = HexButton(icon: UIImage.switchIcon, text: "Calendar")
    return btn
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    view.addSubview(hexBtn)
    hexBtn.snp.makeConstraints { make in
      make.center.equalTo(self.view)
      make.width.equalTo(200)
      make.height.equalTo(72)
    }
  }
}
