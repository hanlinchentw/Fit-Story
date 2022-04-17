//
//  UIbutton+extensions.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/17.
//

import UIKit
extension UIButton {
  func createChakraButton(text: String, withWeight weight: UIFont.FontWeight, withFont font: UIFont.FontSize, withColor color: UIColor) -> UIButton {
    let btn = UIButton()
    btn.setTitle(text, for: .normal)
    switch (weight) {
    case .regular:
      btn.titleLabel?.font = UIFont.regularChakra(of: font)
    case .medium:
      btn.titleLabel?.font = UIFont.mediumChakra(of: font)
    case .semiBold:
      btn.titleLabel?.font = UIFont.semiBoldChakra(of: font)
    }
    btn.setTitleColor(color, for: .normal)
    return btn
  }

}
