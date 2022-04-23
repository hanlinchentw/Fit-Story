//
//  UIbutton+extensions.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/17.
//

import UIKit
extension UIButton {
  func createChakraButton(text: String, withWeight weight: UIFont.FontWeight, withFont fontSize: UIFont.FontSize, withColor color: UIColor) -> UIButton {
    let btn = UIButton()
    btn.setTitle(text, for: .normal)
    btn.titleLabel?.textAlignment = .center
    btn.setTitleColor(color, for: .normal)
    btn.titleLabel?.font = UIFont().getChakraFont(weight, fontSize)
    return btn
  }

  func applyGradient(colors: [UIColor]) {
    self.layoutIfNeeded()
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [UIColor.lightPurple.cgColor, UIColor.darkPurple.cgColor]
    gradientLayer.type  = .axial
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    gradientLayer.cornerRadius = self.bounds.height/2
    layer.masksToBounds = true
    gradientLayer.frame = self.bounds
    layer.insertSublayer(gradientLayer, at: 0)
  }
}

extension UIBarButtonItem {
  var closeButton: UIBarButtonItem {
    return UIBarButtonItem(image: UIImage.close, style: .plain, target: self, action: nil)
  }
}
