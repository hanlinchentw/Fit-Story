//
//  RecordCollectionViewController.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

private let RECORD_CELL_ID = "RECORD_CELL_ID"
private let RECORD_HEADER_ID = "RECORD_HEADER_ID"
final class RecordCollectionViewController: UIViewController {
  // MARK: - Properties
  private let bag = DisposeBag()
  var source: [OptionalRecord] = [.weight, .bodyFat, .calorieIntake, .leftArmSize,.rightArmSize,.leftThighSize]
  private var collectionView: UICollectionView!
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layoutForCollectionView())
    setupUI()
    setupBinding()
  }
  func layoutForCollectionView() -> UICollectionViewFlowLayout {
    let customLayout = UICollectionViewFlowLayout()
    customLayout.scrollDirection = .vertical
    customLayout.itemSize = CGSize(width: self.view.frame.width, height: 60)
    customLayout.minimumLineSpacing = 32
    customLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 200)
    return customLayout
  }
}
// MARK: - Binding
private extension RecordCollectionViewController {
  func setupBinding() {
    setupCollectionViewBinding()
  }

  func setupCollectionViewBinding() {
    self.collectionView.register(RecordCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RECORD_HEADER_ID)
    self.collectionView.register(RecordCollectionViewCell.self, forCellWithReuseIdentifier: RECORD_CELL_ID)

    let dataSource = RecordCollectionViewController.dataSource()
    Observable.just(source).map { items in
      [SectionModel(model: "first Section", items: items)]
    }
    .asDriver(onErrorJustReturn: [])
    .drive(collectionView.rx.items(dataSource: dataSource))
    .disposed(by: bag)
  }
}
// MARK: - collectionView DataSource
extension RecordCollectionViewController {
  typealias DataSource = RxCollectionViewSectionedReloadDataSource
  static func dataSource() -> DataSource<SectionModel<String, OptionalRecord>> {
    .init(configureCell: { _, collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RECORD_CELL_ID, for: indexPath)
      guard let cell = cell as? RecordCollectionViewCell else { fatalError("/RecordCollectionViewController missing Cell")}
      cell.record.accept(item)
      return cell
    },  configureSupplementaryView: { _, collectionView, kind, indexPath in
      switch kind {
      case UICollectionView.elementKindSectionHeader:
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RECORD_HEADER_ID, for: indexPath)
        guard let header = header as? RecordCollectionViewHeader else { fatalError("/RecordCollectionViewController missing Header")}
        return header
      default:
        assert(false, "Unexpected element kind")
      }
    })
  }
}
// MARK: - UI
private extension RecordCollectionViewController {
  func setupUI() {
    setupCollectionView()
  }

  func setupCollectionView() {
    collectionView.backgroundColor = .background1
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
