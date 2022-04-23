//
//  PhotoSelectCollectionView.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/23.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

private let PHOTO_CELL_ID = "PHOTO_CELL_ID"
private let PHOTO_FOOTER_ID = "PHOTO_FOOTER_ID"
class PhotoSelectCollectionView: UICollectionView {
  private let bag = DisposeBag()
  init() {
    super.init(frame: .zero, collectionViewLayout: .init())
    self.collectionViewLayout = layoutForCollectionView()
    backgroundColor = .background1
    setupCollectionViewBinding()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func layoutForCollectionView() -> UICollectionViewFlowLayout {
    let customLayout = UICollectionViewFlowLayout()
    customLayout.scrollDirection = .horizontal
    customLayout.itemSize = CGSize(width: 90, height: 120)
    customLayout.footerReferenceSize = CGSize(width: 90, height: 120)
    customLayout.minimumLineSpacing = 24
    return customLayout
  }
}

extension PhotoSelectCollectionView {
  func setupCollectionViewBinding() {
    self.register(PhotoSelectCollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PHOTO_FOOTER_ID)
    self.register(PhotoSelectCollectionViewCell.self, forCellWithReuseIdentifier: PHOTO_CELL_ID)

    let dataSource = PhotoSelectCollectionView.dataSource()
    Observable.just([]).map { items in
      [SectionModel(model: "first Section", items: items)]
    }
    .asDriver(onErrorJustReturn: [])
    .drive(self.rx.items(dataSource: dataSource))
    .disposed(by: bag)
  }
}
// MARK: - collectionView DataSource
extension PhotoSelectCollectionView {
  typealias DataSource = RxCollectionViewSectionedReloadDataSource
  static func dataSource() -> DataSource<SectionModel<String, UIImage>> {
    .init(configureCell: { _, collectionView, indexPath, _ in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PHOTO_CELL_ID, for: indexPath)
      guard let cell = cell as? PhotoSelectCollectionViewCell else { fatalError("/RecordCollectionViewController missing Cell")}
      return cell
    }, configureSupplementaryView: { _, collectionView, kind, indexPath in
      switch kind {
      case UICollectionView.elementKindSectionFooter:
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PHOTO_FOOTER_ID, for: indexPath)
        guard let footer = footer as? PhotoSelectCollectionViewFooter else { fatalError("/RecordCollectionViewController missing Header")}
        return footer
      default:
        assert(false, "Unexpected element kind")
      }
    })
  }
}
