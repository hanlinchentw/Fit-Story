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
    let topVC = UIApplication
      .shared
      .connectedScenes
      .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
      .first { $0.isKeyWindow }?.rootViewController
    if let topVC = topVC as? UINavigationController {
      return topVC.visibleViewController
    }
    return topVC
  }

  func presentDatePickerViewController() {
    let datePicker = DatePickerViewController()
    datePicker.modalPresentationStyle = .overFullScreen
    datePicker.modalTransitionStyle = .crossDissolve
    self.topViewController?.present(datePicker, animated: true, completion: nil)
  }

  func presentAlbum() {

  }
}
