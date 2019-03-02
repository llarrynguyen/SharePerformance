//
//  SPAdViewController.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/27/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class SPAdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }


}

extension SPAdViewController: ViewControllerable {
    var name: String {
        return ViewControllerType.adViewController
    }
    
    var tabItemImageString: String {
        return Resources.ImageNames.ad
    }
    
    var viewModel: Any? {
        return SPAdViewModel(networkManager: NetworkManager())
        
    }
    
    func setupViewController() {
        self.view.backgroundColor = AppColor.mainBackgroud.value
    }
    
}


