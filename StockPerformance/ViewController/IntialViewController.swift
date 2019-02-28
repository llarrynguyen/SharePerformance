//
//  IntialViewController.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/27/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit


protocol ViewControllerable {
    var name: String {get set}
    var tabItemImageString: String {get set}
    var viewModel: Any? {get set}
    func setupViewController()
}

enum ViewController: String {
    case SearchViewController
    case SectorViewController
    case NewsViewController
    case YouViewController
    case AdViewController
}

class IntialViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpViewController()
    }
    
//    private func setupInitial() {
//        self.tabBar.tintColor = UIC
//    }
    private func setUpViewController() {
        let searchVC = SPSearchViewController()
        let sectorVC = SPSectorViewController()
        let newsVC = SPNewsViewController()
        let youVC = SPYouViewController()
        let adVC = SPAdViewController()
        
    }
}
