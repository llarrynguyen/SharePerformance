//
//  CompanySearch.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/1/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

struct CompanySearch {
    let symbol: String
    let name: String
    let region: String
}

struct CompanySearchResponse {
    private enum CompanySearchRootCodingKey: String, CodingKey {
        case bestMatches
    }
    
    private enum CompanySearchCodingKey: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case region = "4. region"
    }

    var companySearches: [CompanySearch]

}


extension CompanySearchResponse: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let rootContainer = try decoder.container(keyedBy: CompanySearchRootCodingKey.self)
            var container = try rootContainer.nestedUnkeyedContainer(forKey: .bestMatches)
            var searches = [CompanySearch]()
            while !container.isAtEnd {
                let newsArrayContainer = try container.nestedContainer(keyedBy: CompanySearchCodingKey.self)
                let symbol = try newsArrayContainer.decode(String.self, forKey:.symbol)
                let name = try newsArrayContainer.decode(String.self, forKey:.name)
                let region = try newsArrayContainer.decode(String.self, forKey:.region)
                searches.append(CompanySearch(symbol: symbol, name: name, region: region))
            }
            
            guard let _ = searches.first else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath + [CompanySearchRootCodingKey.bestMatches], debugDescription: "searches cannot be empty"))
            }
            
            self.companySearches = searches
        } catch {
            throw AppError.decodeError
        }
     
    }
}
