//
//  SPSectorViewController.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/26/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class SPSectorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

extension SPSectorViewController: ViewControllerable {
    var name: String {
        return ViewControllerType.sectorViewController
    }
    
    var tabItemImageString: String {
        return Resources.ImageNames.sector
    }
    
    var viewModel: Any? {
        return SPSectorViewModel()
        
    }
    
    func setupViewController() {
        //
    }
}

