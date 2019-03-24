//
//  ViewModelable.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/1/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

protocol ViewModelable {
    var delegate: Any {get}
    var networkManager: NetworkManager {get}
}


protocol ViewControllerable {
    var name: String {get}
    var tabItemImageString: String {get}
    var viewModel: Any? {get}
    func setupViewController()
}

class CollectionViewFactor {
    private static var instance = CollectionViewFactor()
    
    class func sharedInstance() -> CollectionViewFactor {
        return instance
    }
    
    func constructViewController(of type: Industry) -> UICollectionView {
        switch type {
        case .Finance:
            return UICollectionView()
        case .Energy:
            return UICollectionView()
        case .Technology:
            return UICollectionView()
        case .Healthcare:
            return UICollectionView()
        case .Utilities:
            return UICollectionView()
        case .ConsumerService:
            return UICollectionView()
        }
    }
}
