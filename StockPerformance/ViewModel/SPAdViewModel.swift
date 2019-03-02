//
//  SPAdViewModel.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/27/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

protocol SPAdViewModelProtocol: class {
    func didLoadAddInfo()
}

class SPAdViewModel {
    var networkManager: NetworkManager!
    weak var delegate: SPAdViewModelProtocol?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
}
