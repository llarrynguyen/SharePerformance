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
    let high: String
    let low: String
    let price: String
    let volume: String
    let change: String
    let changePercentage: String
}

extension Stock: Decodable {
    private enum StockCodingKeys: String, CodingKey {
        case symbol           = "01. symbol"
        case open             = "02. open"
        case close            = "08. previous close"
        case high             = "03. high"
        case low              = "04. low"
        case price            = "05. price"
        case volume           = "06. volume"
        case change           = "09. change"
        case changePercentage = "10. change percent"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StockCodingKeys.self)
        symbol = try container.decode(String.self, forKey: .symbol)
        open = try container.decode(String.self, forKey: .open)
        close = try container.decode(String.self, forKey: .close)
        high = try container.decode(String.self, forKey: .high)
        low = try container.decode(String.self, forKey: .low)
        price = try container.decode(String.self, forKey: .price)
        volume = try container.decode(String.self, forKey: .volume)
        change = try container.decode(String.self, forKey: .change)
        changePercentage = try container.decode(String.self, forKey: .changePercentage)
    }
}
