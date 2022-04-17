//
//  HexButton.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/9.
//

import UIKit
import RxSwift
import RxCocoa

struct HexButtonProps {
  let icon: UIImage
  let text: String
  let onPressd: () -> Void
}
class HexButton: UIButton {
  let bag = DisposeBag()

  init(with props: HexButtonProps) {
    super.init(frame: .zero)
    setupButtonProps(withProps: props)
    setupButtonTapBinding(onPressd: props.onPressd)
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
    let slope: CGFloat = 8
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

extension HexButton {
  func setupButtonProps(withProps props: HexButtonProps) {
    self.titleLabel?.font = UIFont.semiBoldChakra(of: .h6)
    self.setImage(props.icon, for: .normal)
    self.setTitle(props.text, for: .normal)
    self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: -6)
    self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
  }
  func setupButtonTapBinding(onPressd: @escaping() -> Void) {
    self.rx.tap.bind { _ in
      onPressd()
    }.disposed(by: bag)
  }
}
