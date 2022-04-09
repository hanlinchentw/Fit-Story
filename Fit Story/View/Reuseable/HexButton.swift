//
//  HexButton.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/9.
//

import UIKit

class HexButton: UIButton {
  let slope: CGFloat = 8
  init(icon: UIImage, text: String) {
    super.init(frame: .zero)
    self.titleLabel?.font = UIFont.semiBoldChakra(of: UIFont.H6)
    self.setImage(icon, for: .normal)
    self.setTitle(text, for: .normal)
    self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: -6)
    self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func draw(_ rect: CGRect) {
    let path = makePath()
    let layer = CAShapeLayer()
    layer.lineWidth = 1
    layer.path = path.cgPath
    layer.strokeColor = UIColor.lightGray.cgColor
    layer.fillColor = UIColor.clear.cgColor
    self.layer.addSublayer(layer)
  }
  func makePath() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: bounds.minX+slope, y: bounds.minY))
    path.addLine(to: CGPoint(x: bounds.maxX - slope, y: bounds.minY))
    path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY+slope))
    path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY-slope))
    path.addLine(to: CGPoint(x: bounds.maxX - slope, y: bounds.maxY))
    path.addLine(to: CGPoint(x: bounds.minX+slope, y: bounds.maxY))
    path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY-slope))
    path.addLine(to: CGPoint(x: bounds.minX, y: slope))
    path.addLine(to: CGPoint(x: bounds.minX+slope, y: bounds.minY))
    path.close()
    return path
  }
}
