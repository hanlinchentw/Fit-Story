//
//  PhotoPlaceholder.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/23.
//

import UIKit
import SnapKit

class PhotoPlaceholder: UIView {
  let plusImageView: UIImageView = {
    let iv = UIImageView(image: UIImage.plusSmall)
    iv.contentMode = .scaleToFill
    return iv
  }()
  override init(frame: CGRect) {
    super.init(frame: .zero)
    backgroundColor = .clear
    addSubview(plusImageView)
    plusImageView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    self.layoutIfNeeded()

    let layer = CAShapeLayer()
    layer.lineWidth = 1
    layer.strokeColor = UIColor.white.withAlphaComponent(0.2).cgColor
    layer.lineDashPattern = [7, 3]
    layer.cornerRadius = 4
    layer.fillColor = UIColor.background1.cgColor

    let path = CGMutablePath()
    path.addRect(self.bounds)
    layer.path = path

    self.layer.insertSublayer(layer, at: 0)
  }
}
