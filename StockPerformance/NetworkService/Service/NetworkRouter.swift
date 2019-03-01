//
//  NetworkRouter.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/28/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter : class {
    associatedtype EndPoint : EndpointProtocol
    func request( _ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
