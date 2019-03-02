//
//  SPSectorViewModel.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/27/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

protocol SPSectorViewModelProtocol: class {
    func didFinishLoadingSectorInfo()
}

class SPSectorViewModel {
    var networkManager: NetworkManager!
    var industryPerformance: IndustryPerformance?
    weak var delegate: SPSectorViewModelProtocol?
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func loadIndustryPerformanceInfo(){
        self.networkManager.getSectorPerformance { [weak self](industryPerformance, errorMessage) in
            if errorMessage == nil {
                self?.industryPerformance = industryPerformance
                self?.delegate?.didFinishLoadingSectorInfo()
            }
        }
    }
    
}
