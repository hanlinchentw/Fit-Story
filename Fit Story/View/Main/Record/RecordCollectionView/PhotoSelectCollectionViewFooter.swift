//
//  PhotoSelectCollectionViewFooter.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhotoSelectCollectionViewFooter: UICollectionReusableView {
  private let bag = DisposeBag()
  let placeHolder = PhotoPlaceholder()
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupPhotoContainer()
    setupOnPressed()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupPhotoContainer() {
    addSubview(placeHolder)
    placeHolder.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  func setupOnPressed() {
    let tap = UITapGestureRecognizer()
    tap.rx.event.bind { _ in
      let actions: [UIAlertAction] = [.action(title: "Take Photo", style: .default),
                                      .action(title: "Choose from library", style: .default),
                                      .action(title: "Cancel", style: .cancel)]
      try? UIAlertController.present(style: .actionSheet, actions: actions)
        .subscribe(onNext: { index in
          print(index)
        }).disposed(by: self.bag)
    }.disposed(by: bag)
    placeHolder.addGestureRecognizer(tap)
  }
}
