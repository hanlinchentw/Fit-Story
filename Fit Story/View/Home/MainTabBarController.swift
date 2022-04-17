//
//  MainTabBarController.swift
//  Fit Story
//
//  Created by 陳翰霖 on 2022/4/17.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    setUpTabBar()

  }

  func setUpTabBar() {
    UITabBar.appearance().isTranslucent = true
    UITabBar.appearance().shadowImage = UIImage()
    UITabBar.appearance().backgroundImage = UIImage()
    UITabBar.appearance().barTintColor = .background

    let mainVC = MainViewController()
    let mainTabBarItem = UITabBarItem(title: nil, image: UIImage.planetDefault, tag: 0)
    mainVC.tabBarItem = mainTabBarItem
    mainVC.tabBarItem.selectedImage = UIImage.planetActive
    self.viewControllers = [mainVC]
  }

}
