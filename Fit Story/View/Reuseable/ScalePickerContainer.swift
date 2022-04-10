//
//  ScalePickerContainer.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/10.
//

import UIKit
import SnapKit

class ScalePickerContainer: UIView {
  private let scalePicker: ScalePicker = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: 16, height: 48)
    layout.minimumLineSpacing = -5
    let picker = ScalePicker(frame: .zero, collectionViewLayout: layout)
    return picker
  }()
  private let middleBarImageView: UIImageView = {
    let iv = UIImageView(image: UIImage.middleBar)
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  private var displayScaleLabel: UILabel = {
    let label = UILabel()
    label.text = "10"
    label.textColor = .darkGreen
    label.font = UIFont.semiBoldChakra(of: UIFont.H4)
    return label
  }()
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(scalePicker)
    scalePicker.snp.makeConstraints { make in
      make.left.equalToSuperview()
      make.bottom.equalToSuperview()
      make.top.equalToSuperview()
      make.right.greaterThanOrEqualToSuperview()
    }
    addSubview(middleBarImageView)
    middleBarImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(-16)
    }
    addSubview(displayScaleLabel)
    displayScaleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(middleBarImageView.snp.top).offset(-8)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
