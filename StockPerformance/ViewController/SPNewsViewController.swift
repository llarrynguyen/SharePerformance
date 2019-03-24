//
//  SPNewsViewController.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/27/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class SPNewsViewController: UIViewController {
    
    weak var mainScrollView: UIScrollView!
    weak var topView: NewsView!
    weak var financeCollection: UICollectionView!
    weak var energyCollection: UICollectionView!
    weak var techCollection: UICollectionView!
    weak var unilitiesCollection: UICollectionView!
    weak var healthcareCollection: UICollectionView!
    weak var consumerServicesCollection: UICollectionView!
    
    var displayedIndustries: [Industry] = []

    override func loadView() {
        super.loadView()
        displayedIndustries = [.Finance,.Energy,.Technology,.Utilities,.ConsumerService,.Healthcare]
        setupScrollView()
        setupTopView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        
        self.mainScrollView.delegate = self
    }
    
    fileprivate func setupScrollView(){
        let mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        mainScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2)
        self.view.addSubview(mainScrollView)
        self.mainScrollView = mainScrollView
    }
    
    fileprivate func setupTopView(){
        let topView = NewsView()
        topView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 3/5)
        self.mainScrollView.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.view.topAnchor),
            topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
        self.topView = topView
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

extension SPNewsViewController: UIScrollViewDelegate {
    
}
