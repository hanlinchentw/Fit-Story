//
//  RecordCollectionViewCell.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/23.
//

import UIKit
import RxSwift
import RxCocoa

class RecordCollectionViewCell: UICollectionViewCell {
  // MARK: - Properties
  private var bag = DisposeBag()

  var record = PublishRelay<OptionalRecord>()

  private var vm = RecordCollectionViewCellViewModel()

  private let titleLabel = UILabel().createChakraLabel(text: "Record",
                                                       withWeight: .semiBold, withFont: .h6, withColor: .white)

  private let textField : UITextField = {
    let tf = UITextField()
    tf.font = UIFont.semiBoldChakra(of: .h2)
    tf.textColor = .white
    tf.attributedPlaceholder = NSAttributedString(string: "0",
                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.2)])
    return tf
  }()

  private let unitLabel = UILabel().createChakraLabel(text: "kg",
                                                      withWeight: .medium, withFont: .h6, withColor: UIColor.white.withAlphaComponent(0.6))
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    setupOutputBinding()
    setupInput()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func prepareForReuse() {
    super.prepareForReuse()
    bag = DisposeBag()
  }
}
// MARK: - UI
extension RecordCollectionViewCell {
  func setupUI() {
    setupTitleLabel()
    setupTextField()
  }

  func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(20)
    }
  }

  func setupTextField() {
    addSubview(textField)
    textField.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(4)
      make.left.equalTo(titleLabel)
    }
    addSubview(unitLabel)
    unitLabel.snp.makeConstraints { make in
      make.firstBaseline.equalTo(textField)
      make.left.equalTo(textField.snp.right).offset(4)
    }
  }
}

// MARK: - Binding
extension RecordCollectionViewCell {
  func setupOutputBinding() {
    vm.titleOutput
      .bind(to: titleLabel.rx.text)
      .disposed(by: bag)
    vm.unitOutput
      .bind(to: unitLabel.rx.text)
      .disposed(by: bag)
  }
  func setupInput() {
    record.bind(to: vm.recordInput).disposed(by: bag)
  }
}
