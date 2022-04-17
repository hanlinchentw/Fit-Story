//
//  MainTabBarController.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/17.
//

import UIKit
import SnapKit

class MainTabBarController: UITabBarController {
// MARK: - Tab View
  private static let home = HomeViewController()
  private static let progress = ProgressViewController()
  private static let album = AlbumViewController()
// MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    setUpTabBar()
  }
// MARK: - Set up UI
  func setUpTabBar() {
    UITabBar.appearance().isTranslucent = true
    UITabBar.appearance().shadowImage = UIImage()
    UITabBar.appearance().backgroundImage = UIImage()
    UITabBar.appearance().barTintColor = .background

    let tab1 = createTabItem(withDefaultImage: UIImage.planetDefault,
                             withSelectedImage: UIImage.planetActive,
                             containVC: MainTabBarController.home)

    let tab2 = createTabItem(withDefaultImage: UIImage.chartDefault,
                             withSelectedImage: UIImage.chartActive,
                             containVC: MainTabBarController.progress)

    let tab3 = createTabItem(withDefaultImage: UIImage.albumDefault,
                             withSelectedImage: UIImage.albumActive,
                             containVC: MainTabBarController.album)

    let tab4 = createTabItem(withDefaultImage: UIImage.createRecord,
                             withSelectedImage: UIImage.createRecord,
                             containVC: UIViewController(),
                             withTag: 3)
    self.viewControllers = [tab1, tab2, tab3, tab4]
  }
}
// MARK: - TabBarDelegate
extension MainTabBarController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    if (viewController.tabBarItem.tag == 3) {
      let nav = UINavigationController(rootViewController: CreateRecordViewController())
      let topVC = PresentationHelper.shared.topViewController
      topVC?.present(nav, animated: true, completion: nil)
      return false
    }
    return true
  }
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    guard let index = tabBar.items?.firstIndex(of: item), let imageView = tabBar.subviews[index+1].subviews.first as? UIImageView else {
      return
    }
    let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
    bounceAnimation.duration = TimeInterval(0.3)
    bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic

    imageView.layer.add(bounceAnimation, forKey: nil)
  }
}

extension MainTabBarController {
  func createTabItem(withDefaultImage defaultImage: UIImage, withSelectedImage selectedImage: UIImage, containVC vc: UIViewController, withTag tag: Int? = nil) -> UIViewController {
    let nav = UINavigationController(rootViewController: vc)
    nav.tabBarItem.image = defaultImage
    nav.tabBarItem.selectedImage = selectedImage
    if let tag = tag {
      nav.tabBarItem.tag = tag
    }
    return nav
  }
}
