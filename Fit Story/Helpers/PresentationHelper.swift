//
//  PresentationHelper.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/17.
//

import UIKit

class PresentationHelper: NSObject {
  static let shared = PresentationHelper()

  var topViewController: UIViewController? {
    return UIApplication.shared.keyWindow?.rootViewController
  }
}
