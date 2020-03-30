//
//  News.swift
//  NewsApp
//
//  Created by Izzatilla on 29.03.2020.
//  Copyright © 2020 Izzatilla. All rights reserved.
//

import Foundation

struct NewsResponse: Codable {
    var status: String
    var totalResults: Int
    var articles: [News]
}

struct News: Codable {
    var author: String?
    var title: String?
    var description: String?
    var content: String?
    var publishedAt: String
    var url: String
    var urlToImage: String?
    
    func getPublishedDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:publishedAt)!
        return date
    }
}
