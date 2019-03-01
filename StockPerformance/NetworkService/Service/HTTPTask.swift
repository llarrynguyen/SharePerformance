//
//  HTTPTask.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/28/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    case requestWithParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestWithParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
    
    // Other cases if you want
}
