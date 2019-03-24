//
//  SPSearchViewModel.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/27/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

enum Industry {
    case Energy
    case Finance
    case Healthcare
    case Utilities
    case Technology
    case ConsumerService
}

protocol SPSearchViewModelProtocol: class {
    func haveSearchedForKeyword()
}

class SPSearchViewModel {
    var networkManager: NetworkManager!
    
    weak var delegate: SPSearchViewModelProtocol?
    var searches: [CompanySearch]?
    
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func search(keywork: String){
        networkManager.search(keywork: keywork) { [weak self] (searchResponse, errorMessage) in
            if errorMessage == nil {
                self?.searches = searchResponse?.companySearches
                self?.delegate?.haveSearchedForKeyword()
            }
        }
    }
    
    func numberOfSearchResults() -> Int {
        return searches?.count ?? 0
    }
}
