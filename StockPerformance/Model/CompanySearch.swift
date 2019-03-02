//
//  CompanySearch.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/1/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

struct CompanySearchResponse {
    private enum CompanySearchRootCodingKey: String, CodingKey {
        case bestMatches
    }
    
    private enum CompanySearchCodingKey: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case region = "4. region"
    }
    struct CompanySearch {
        let symbol: String
        let name: String
        let region: String
    }
    
    var companySearch: CompanySearch

}


extension CompanySearchResponse: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let rootContainer = try decoder.container(keyedBy: CompanySearchRootCodingKey.self)
            let container = try rootContainer.nestedContainer(keyedBy: CompanySearchCodingKey.self, forKey: CompanySearchRootCodingKey.bestMatches)
            let symbol = try container.decode(String.self, forKey: .symbol)
            let name = try container.decode(String.self, forKey: .name)
            let region = try container.decode(String.self, forKey: .region)
            companySearch = CompanySearch(symbol: symbol, name: name, region: region)
        } catch {
            throw AppError.decodeError
        }
     
    }
}
