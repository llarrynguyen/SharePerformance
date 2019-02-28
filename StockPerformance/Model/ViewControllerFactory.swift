//
//  ViewControllerFactory.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/27/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

protocol ViewControllerable {
    var name: String {get}
    var tabItemImageString: String {get}
    var viewModel: Any? {get}
    func setupViewController()
}

enum SPViewController {
    case SearchViewController
    case SectorViewController
    case NewsViewController
    case YouViewController
    case AdViewController
}

class ViewControllerFactory {
    private static var instance = ViewControllerFactory()
    
    class func sharedInstance() -> ViewControllerFactory {
        return instance
    }
    
    func constructViewController(of type: SPViewController) -> ViewControllerable {
        switch type {
        case .SearchViewController:
            return SPSearchViewController()
        case .SectorViewController:
            return SPSectorViewController()
        case .NewsViewController:
            return SPNewsViewController()
        case .YouViewController:
            return SPYouViewController()
        case .AdViewController:
            return SPAdViewController()
        }
    }
}
