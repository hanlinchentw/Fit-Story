//
//  MainViewController.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/9.
//

import UIKit

class MainViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    let label = UILabel()
    label.text = "Hello world"
    label.font = UIFont.semiBoldChakra(of: UIFont.H1)
    label.textColor = UIColor.red
    label.frame = CGRect(x: 200, y: 200, width: 100, height: 300)
    view.addSubview(label)
  }
}
