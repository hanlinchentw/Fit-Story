//
//  ScalePickerCell.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ScalePickerCell: UICollectionViewCell {
// MARK: - Properties
  // Rx
  var vm = PublishRelay<ScalePickerCellViewModel?>()
  private(set) var bag = DisposeBag()
  // UI
  private let scaleView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 1, alpha: 0.2)
    return view
  }()
  private let scaleTextLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 12)
    return label
  }()
// MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setUpUI()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func prepareForReuse() {
    super.prepareForReuse()
    bag = DisposeBag()
  }
  func setUpUI() {
    self.contentView.addSubview(self.scaleView)
    self.contentView.addSubview(self.scaleTextLabel)
    self.scaleTextLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-4)
    }
  }
// MARK: - Binding
  func setupBinding() {
    vm.asDriver(onErrorJustReturn: nil)
      .drive { vm in
        guard let vm = vm else { return }
        self.scaleTextLabel.text = vm.displayScaleString
        self.layer.zPosition = vm.cellZPosition
        self.scaleView.snp.removeConstraints()
        self.scaleView.snp.makeConstraints { make in
          make.width.equalTo(1)
          make.height.equalTo(vm.scaleHeight)
          make.centerX.equalToSuperview()
          make.bottom.equalToSuperview().offset(-24)
        }
        self.layoutIfNeeded()
    }
    .disposed(by: bag)
  }
}
