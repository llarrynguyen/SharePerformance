//
//  NetworkManager.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/28/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

struct NetworkManager {
    static let environment : NetworkEnvironment = .production
    static let apiKey = "9JD3KCRJN2LAD8G6"
    private let router = Router<SPAPIClient>()
    
    enum NetworkResponse: String {
        case sucesss
        case authError       = "This request required authentication"
        case badRequest      = "Bad request"
        case outdated        = "The url info is out of date"
        case failed          = "Request failed"
        case noData          = "The response return has not data"
        case failedToDecode  = "We could not decode this response"
    }
    
    enum Result<String>{
        case success
        case failure(String)
    }
}
