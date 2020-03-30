//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/11.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "Problems with server"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    static let environment : NetworkEnvironment = .production
    static var apiKey = "2db2e9d00e8c4cceb07fbc906e35c7dd"
    let router = Router<NewsApi>()
    
    func getTopNews(page: Int, completion: @escaping (_ newsResponse: NewsResponse?,_ error: String?)->()){
            router.request(.topNews(page: page)) { data, response, error in
                
                if error != nil {
                    completion(nil, "Please check your network connection.")
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
    //                 print(333,NSString(data: data!, encoding:String.Encoding.utf8.rawValue)!)
                    switch result {
                    case .success:
                       
                        guard let responseData = data else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
                            print(responseData)
                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                            print(jsonData)
                            let apiResponse = try JSONDecoder().decode(NewsResponse.self, from: responseData)
                            completion(apiResponse,nil)
                        }catch {
                            print(error)
                            completion(nil, NetworkResponse.unableToDecode.rawValue)
                        }
                    case .failure(let networkFailureError):
                        completion(nil, networkFailureError)
                    }
                }
            }
        }
    
    func getSearchResults(page: Int, searchString: String,completion: @escaping (_ newsResponse: NewsResponse?,_ error: String?)->()){
            router.request(.search(page: page, searchString: searchString)) { data, response, error in
                
                if error != nil {
                    completion(nil, "Please check your network connection.")
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
    //                 print(333,NSString(data: data!, encoding:String.Encoding.utf8.rawValue)!)
                    switch result {
                    case .success:
                       
                        guard let responseData = data else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
                            print(responseData)
                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                            print(jsonData)
                            let apiResponse = try JSONDecoder().decode(NewsResponse.self, from: responseData)
                            completion(apiResponse,nil)
                        }catch {
                            print(error)
                            completion(nil, NetworkResponse.unableToDecode.rawValue)
                        }
                    case .failure(let networkFailureError):
                        completion(nil, networkFailureError)
                    }
                }
            }
        }
    
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
