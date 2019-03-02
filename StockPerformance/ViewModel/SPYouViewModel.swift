//
//  SPYouViewModel.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/27/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

protocol SPYouViewModelProtocol: class {
    func didLoadYou()
}

class SPYouViewModel {
    var networkManager: NetworkManager!
    
    weak var delegate: SPYouViewModelProtocol?
    
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
}
