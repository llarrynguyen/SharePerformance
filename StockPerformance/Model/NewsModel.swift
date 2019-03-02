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

struct NewsRootResponse {
    
    enum NewsRootCodingKey: String, CodingKey {
        case articles
    }
    
    private enum NewsCodingKey: String, CodingKey {
        case title = "title"
        case url = "url"
        case date = "publishedAt"
    }
    
    var newsArray: [News]
}

extension NewsRootResponse: Decodable {
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: NewsRootCodingKey.self)
        var container = try rootContainer.nestedUnkeyedContainer(forKey: .articles)
        var array = [News]()
        while !container.isAtEnd {
            let newsArrayContainer = try container.nestedContainer(keyedBy: NewsCodingKey.self)
            let title = try newsArrayContainer.decode(String.self, forKey:.title)
            let url = try newsArrayContainer.decode(String.self, forKey:.url)
            let date = try newsArrayContainer.decode(String.self, forKey:.date)
            array.append(News(title: title, url: url, date: date))
        }
        self.newsArray = array
    }
}


