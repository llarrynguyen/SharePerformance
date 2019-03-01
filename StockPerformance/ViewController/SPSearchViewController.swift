//
//  SPSearchViewController.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/26/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class SPSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

}

extension SPSearchViewController: ViewControllerable {
    var name: String {
        return ViewControllerType.searchViewController
    }
    
    var tabItemImageString: String {
        return Resources.ImageNames.search
    }
    
    var viewModel: Any? {
        return SPSearchViewModel()
       
    }
    
    func setupViewController() {
        self.view.backgroundColor = AppColor.mainBackgroud.value
    }
}
