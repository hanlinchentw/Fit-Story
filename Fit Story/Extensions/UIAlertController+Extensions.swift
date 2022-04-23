//
//  UIAlertController+Extensions.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/24.
//

import UIKit
import RxSwift
import RxCocoa

extension UIAlertAction {
  static func action(title: String?, style: UIAlertAction.Style) -> UIAlertAction {
    return UIAlertAction(title: title, style: style)
  }
}
extension UIAlertController {
  static func present(style: UIAlertController.Style, actions: [UIAlertAction]) throws -> Observable<Int> {
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: style)
    alert.overrideUserInterfaceStyle = .dark
    alert.view.tintColor = .white
    return Observable.create { observer in
      actions.enumerated().forEach { index, action in
        let action = UIAlertAction(title: action.title, style: action.style) { _ in
          observer.onNext(index)
          observer.onCompleted()
        }
        alert.addAction(action)
      }
      if let topVC = PresentationHelper.shared.topViewController {
        topVC.present(alert, animated: true, completion: nil)
      } else {
        fatalError("/UIAlertController extension Top view controller doesn't exist.")
      }
      return Disposables.create {
        alert.dismiss(animated: true, completion: nil)
      }
    }
  }
}
