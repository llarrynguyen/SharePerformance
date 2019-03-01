//
//  ParameterEncoding.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/28/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

public typealias Parameters = [String : Any]

public enum NetworkError: String, Error {
    case ParametersNil    =  "Parameters are nil."
    case FailedEncoding   =  "Failed to encode parameters"
    case missingURL       =  "URL is nil"
}
public protocol ParameterEnconder {
    static func encode (urlRequest: inout URLRequest, with parameters: Parameters) throws
}


