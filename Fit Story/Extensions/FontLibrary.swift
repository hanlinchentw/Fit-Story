//
//  FontLibrary.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/9.
//

import UIKit

extension UIFont {
  // Font Scale
  static var H1: CGFloat{
    return CGFloat(32);
  };
  static var H2: CGFloat{
    return CGFloat(28);
  };
  static var H3: CGFloat{
    return CGFloat(24);
  };
  static var H4: CGFloat{
    return CGFloat(20);
  };
  static var H5: CGFloat{
    return CGFloat(17);
  };
  static var H6: CGFloat{
    return CGFloat(16);
  };
  static var H7: CGFloat{
    return CGFloat(14);
  };
  static var H8: CGFloat{
    return CGFloat(12);
  };
  // Chakra Petch
  static func SemiBoldChakra(of size: CGFloat) -> UIFont? {
    return UIFont(name: "ChakraPetch-SemiBold", size: size)
  }
  static func MediumChakra(of size: CGFloat) -> UIFont? {
    return UIFont(name: "ChakraPetch-Medium", size: size)
  }
  static func RegularChakra(of size: CGFloat) -> UIFont? {
    return UIFont(name: "ChakraPetch-Regular", size: size)
  }
}
