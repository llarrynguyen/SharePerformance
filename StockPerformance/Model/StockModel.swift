//
//  StockModel.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/1/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

struct Stock {
    let symbol: String
    let open: String
    let close: String
    let low: String
    let high: String
    let price: String
    let volume: String
    let change: String
    let changePercent: String
}

extension Stock: Decodable {
    
}
