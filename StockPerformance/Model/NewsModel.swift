//
//  NewsModel.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/1/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import Foundation

struct News {
    let title: String
    let url: String
    let date: String
}

extension News: Decodable {
    private enum NewsCodingKey: String, CodingKey {
        case title = "title"
        case url = "url"
        case date = "publishedAt"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NewsCodingKey.self)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
        date = try container.decode(String.self, forKey: .date)
    }
}
