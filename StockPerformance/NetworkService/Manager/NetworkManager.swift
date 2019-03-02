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
    static let newsApiKey = "21bc0c40b74246059954e3d60298256e"
    private let router = Router<SPAPIClient>()
    
    enum NetworkResponse: String {
        case sucesss
        case authError       = "This request required authentication"
        case badRequest      = "Bad request"
        case outdated        = "The url info is out of date"
        case failed          = "Request failed"
        case noData          = "The response return has not data"
        case failedToDecode  = "We could not decode this response"
        case requestError    = "The request returns an error"
    }
    
    enum Result<String>{
        case success
        case failure(String)
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getNews(source: String, completion: @escaping (_ newsResponse: NewsRootResponse?, _ error: String?) -> ()){
        router.request(.news(sources:source)){ data, response, error in
            if error != nil {
                completion(nil,NetworkResponse.requestError.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let data = data else {
                        completion(nil,NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let decodedResponse = try JSONDecoder().decode(NewsRootResponse.self, from: data)
                        completion(decodedResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.failedToDecode.rawValue )
                    }
                case .failure(let networkError):
                    completion(nil, networkError)
                }
            }
        }
    }
    
    func getQuote(symbol: String, completion: @escaping (_ newsArray: Stock?, _ error: String?) -> ()){
        router.request(.symbolQuote(function: "GLOBAL_QUOTE", symbol: symbol)){ data, response, error in
            if error != nil {
                completion(nil,NetworkResponse.requestError.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let data = data else {
                        completion(nil,NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let decodedResponse = try JSONDecoder().decode(Stock.self, from: data)
                        completion(decodedResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.failedToDecode.rawValue )
                    }
                case .failure(let networkError):
                    completion(nil, networkError)
                }
            }
        }
    }
    
    func search(keywork: String, completion: @escaping (_ companySearch: CompanySearchResponse?, _ error: String?) -> ()){
        router.request(.symbolQuote(function: "GLOBAL_QUOTE", symbol: keywork)){ data, response, error in
            if error != nil {
                completion(nil,NetworkResponse.requestError.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let data = data else {
                        completion(nil,NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let decodedResponse = try JSONDecoder().decode(CompanySearchResponse.self, from: data)
                        completion(decodedResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.failedToDecode.rawValue )
                    }
                case .failure(let networkError):
                    completion(nil, networkError)
                }
            }
        }
    }
    
    func getSectorPerformance(completion: @escaping (_ sectorPerformance: IndustryPerformance?, _ error: String?) -> ()){
        router.request(.sector(function: "SECTOR")){ data, response, error in
            if error != nil {
                completion(nil,NetworkResponse.requestError.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let data = data else {
                        completion(nil,NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let decodedResponse = try JSONDecoder().decode(IndustryPerformance.self, from: data)
                        completion(decodedResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.failedToDecode.rawValue )
                    }
                case .failure(let networkError):
                    completion(nil, networkError)
                }
            }
        }
    }
    
    
}
