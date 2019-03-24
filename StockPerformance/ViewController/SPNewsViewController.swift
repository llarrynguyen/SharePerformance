//
//  SPNewsViewController.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/27/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class SPNewsViewController: UIViewController {
    
    weak var financeCollection: UICollectionView!
    weak var energyCollection: UICollectionView!
    weak var techCollection: UICollectionView!
    weak var unilitiesCollection: UICollectionView!
    weak var healthcareCollection: UICollectionView!
    weak var consumerServicesCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

}

extension SPNewsViewController: ViewControllerable {
    var name: String {
        return ViewControllerType.newsViewController
    }
    
    var tabItemImageString: String {
        return Resources.ImageNames.news
    }
    
    var viewModel: Any? {
        return SPNewsViewModel(networkManager: NetworkManager())
        
    }
    
    func setupViewController() {
        self.view.backgroundColor = AppColor.mainBackgroud.value
    }
}
