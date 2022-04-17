//
//  UILabel+Extensions.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/17.
//

import UIKit

extension UILabel {
  func createChakraLabel(text: String, withWeight weight: UIFont.FontWeight, withFont font: UIFont.FontSize, withColor color: UIColor) -> UILabel {
    let label = UILabel()
    label.text = text
    switch (weight) {
    case .regular:
      label.font = UIFont.regularChakra(of: font)
    case .medium:
      label.font = UIFont.mediumChakra(of: font)
    case .semiBold:
      label.font = UIFont.semiBoldChakra(of: font)
    }
    label.textColor = color
    return label
  }
}
