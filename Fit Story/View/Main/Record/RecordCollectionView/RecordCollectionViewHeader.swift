//
//  RecordCollectionViewHeader.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/23.
//

import UIKit

class RecordCollectionViewHeader: UICollectionReusableView {
  private var collectionView: PhotoSelectCollectionView!
  private let titleLabel = UILabel().createChakraLabel(text: "Photo", withWeight: .semiBold, withFont: .h6, withColor: .white)
  override init(frame: CGRect) {
    super.init(frame: .zero)
    collectionView = PhotoSelectCollectionView()
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
// MARK: - UI
private extension RecordCollectionViewHeader {
  func setupUI() {
    setupTitleLabel()
    setupCollectionView()
  }
  func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.left.equalToSuperview().offset(20)
    }
  }

  func setupCollectionView() {
    addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(16)
      make.left.equalToSuperview().offset(20)
      make.right.equalToSuperview()
      make.bottom.equalToSuperview().offset(-32)
    }
  }
}
