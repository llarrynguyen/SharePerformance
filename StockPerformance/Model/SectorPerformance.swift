//
//  SectorPerformance.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/1/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

struct IndustryPerformance {
    let informationTechnology: String
    let consumerDiscretionary: String
    let consumerServices: String
    let consumerStaples: String
    let utilities: String
    let realEstate: String
    let financials: String
    let energy: String
    let industrials: String
    let healthCare: String
    let materials: String
}

extension IndustryPerformance: Decodable {
    private enum IndustryCodingKeys: String, CodingKey {
        case informationTechnology = "Information Technology"
        case consumerDiscretionary = "Consumer Discretionary"
        case consumerServices      = "Communication Services"
        case consumerStaples       = "Consumer Staples"
        case utilities             = "Utilities"
        case realEstate            = "Real Estate"
        case financials            = "Financials"
        case energy                = "Energy"
        case industrials           = "Industrials"
        case healthCare            = "Health Care"
        case materials             = "Materials"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: IndustryCodingKeys.self)
        informationTechnology = try container.decode(String.self, forKey: .informationTechnology)
        consumerDiscretionary = try container.decode(String.self, forKey: .consumerDiscretionary)
        consumerServices = try container.decode(String.self, forKey: .consumerServices)
        consumerStaples = try container.decode(String.self, forKey: .consumerStaples)
        utilities = try container.decode(String.self, forKey: .utilities)
        realEstate = try container.decode(String.self, forKey: .realEstate)
        financials = try container.decode(String.self, forKey: .financials)
        energy = try container.decode(String.self, forKey: .energy)
        industrials = try container.decode(String.self, forKey: .industrials)
        healthCare = try container.decode(String.self, forKey: .healthCare)
        materials = try container.decode(String.self, forKey: .healthCare)
    }
}
