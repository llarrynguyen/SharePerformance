//
//  SPNewsViewModel.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/27/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

protocol SPNewsViewModelProtocol: class {
   func didLoadTopNews()
}

class SPNewsViewModel {
    var networkManager: NetworkManager!
    var newsArray: [News] = []
    weak var delete: SPNewsViewModelProtocol?
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func numberOfNewsItems() -> Int {
        return newsArray.count
    }
}
