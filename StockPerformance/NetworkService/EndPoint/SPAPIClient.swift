//
//  SPAPIClient.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/28/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case production
    case qa
    case staging
}

public enum SPAPIClient {
    case sector (function: String)
    case realTimeStock (function: String, symbol: String, timeInterval: String )
    case news (sources: String)
    case companySearch(function: String, keyword: String)
    case symbolQuote(function: String, symbol: String)
}

extension SPAPIClient: EndpointProtocol {
    var envirnmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://www.alphavantage.co/"
        case .qa: return "https://www.alphavantage.co/"
        case .staging: return "https://www.alphavantage.co/"
        }
    }
    var baseURL: URL {
        switch self {
        case .news:
            guard let url = URL(string:"https://newsapi.org/v2/") else {
                fatalError("Please check base url again")
            }
            return url
            
        default:
            guard let url = URL(string: envirnmentBaseURL) else { fatalError("Please check base url again")}
            return url
        }
       
    }
    
    var path: String {
        switch self {
        case .sector, .realTimeStock, .symbolQuote, .companySearch:
            return "query"
        case .news:
            return "top-headlines"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .news(let sources):
            return .requestWithParameters(bodyParameters: nil, urlParameters: ["sources": sources, "apiKey": NetworkManager.newsApiKey])
        case .realTimeStock(let function, let symbol, let timeInterval):
            return .requestWithParameters(bodyParameters: nil, urlParameters: ["function": function, "symbol": symbol, "interval": timeInterval, "apiKey": NetworkManager.apiKey])
        case .companySearch(let function, let keyword):
            return .requestWithParameters(bodyParameters: nil, urlParameters: ["function": function, "keywords": keyword, "apiKey": NetworkManager.apiKey])
        case .symbolQuote(let function, let symbol):
            return .requestWithParameters(bodyParameters: nil, urlParameters: ["function": function, "symbol": symbol, "apiKey": NetworkManager.apiKey])
        case .sector(let function):
            return .requestWithParameters(bodyParameters: nil, urlParameters: ["function": function, "apiKey": NetworkManager.apiKey])
            
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
