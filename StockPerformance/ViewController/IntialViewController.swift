//
//  IntialViewController.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/27/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit


class IntialViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInitial()
        setUpViewController()
    }
    
    private func setupInitial() {
        UITabBar.appearance().barTintColor = AppColor.tabBar.value
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor.white
    }
    
    private func setUpViewController() {
        guard let searchVC = ViewControllerFactory.sharedInstance().constructViewController(of: .SearchViewController) as? SPSearchViewController,
        let sectorVC = ViewControllerFactory.sharedInstance().constructViewController(of: .SectorViewController) as? SPSectorViewController,
        let newsVC = ViewControllerFactory.sharedInstance().constructViewController(of: .NewsViewController) as? SPNewsViewController,
        let youVC = ViewControllerFactory.sharedInstance().constructViewController(of: .YouViewController) as? SPYouViewController,
        let adVC = ViewControllerFactory.sharedInstance().constructViewController(of: .AdViewController) as? SPAdViewController else {
                return
        }
        
        let searchTabItem = UITabBarItem(title: "Search", image: Resources.ImageNames.search.image, tag: 0)
        let sectorTabItem = UITabBarItem(title: "Industries", image: Resources.ImageNames.sector.image, tag: 1)
        let newsTabItem = UITabBarItem(title: "News", image: Resources.ImageNames.news.image, tag: 2)
        let youTabItem = UITabBarItem(title: "Watch List", image: Resources.ImageNames.you.image, tag: 3)
        let adTabItem = UITabBarItem(title: "Ads", image: Resources.ImageNames.ad.image, tag: 4)
        
        searchVC.tabBarItem = searchTabItem
        sectorVC.tabBarItem = sectorTabItem
        newsVC.tabBarItem = newsTabItem
        youVC.tabBarItem = youTabItem
        adVC.tabBarItem = adTabItem
        
        self.viewControllers  = [searchVC, sectorVC, newsVC, youVC, adVC]
        
    }
}
