//
//  PhotosEndPoint.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 02.02.2020.
//  Copyright © 2020 User. All rights reserved.
//
import Foundation


enum NetworkEnvironment {
    case production
}

public enum NewsApi {
    case topNews(page: Int)
    case search(page: Int, searchString: String)
    
}

extension NewsApi: EndPointType {
    
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production:
            return "https://newsapi.org/v2/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: self.environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .topNews:
            return "top-headlines"
        case .search:
            return "everything"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .topNews, .search:
            return .get
            
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .topNews(let page):
            
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["pageSize": 20, "country":"us", "page":page, "apiKey":NetworkManager.apiKey], additionHeaders: [:])
            
        case .search(let page, let searchString):
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["pageSize": 20, "q":searchString, "page":page, "apiKey":NetworkManager.apiKey], additionHeaders: [:])
            
        }
        
    }
    var headers: HTTPHeaders? {
        return [:]
    }
    
}
