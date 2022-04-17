//
//  FontLibrary.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/9.
//

import UIKit

extension UIFont {
  // Font Scale
  enum FontSize: CGFloat {
    case h1 = 32
    case h2 = 28
    case h3 = 24
    case h4 = 20
    case h5 = 17
    case h6 = 16
    case h7 = 14
    case h8 = 12
  }
  enum FontWeight {
    case regular
    case medium
    case semiBold
  }
  // Chakra Petch
  static func semiBoldChakra(of size: FontSize) -> UIFont? {
    UIFont(name: "ChakraPetch-SemiBold", size: size.rawValue)
  }
  static func mediumChakra(of size: FontSize) -> UIFont? {
    UIFont(name: "ChakraPetch-Medium", size: size.rawValue)
  }
  static func regularChakra(of size: FontSize) -> UIFont? {
    UIFont(name: "ChakraPetch-Regular", size: size.rawValue)
  }
}
