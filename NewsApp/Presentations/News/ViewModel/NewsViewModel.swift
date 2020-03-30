//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Izzatilla on 29.03.2020.
//  Copyright © 2020 Izzatilla. All rights reserved.
//

import Foundation

protocol NewsViewModelDelegate: class {
    func isLoadingTableView(loading: Bool)
    func showError(message: String)
    func dataLoaded(news: [News])
    func additionalDataLoaded(news: [News])
    
}

final class NewsViewModel {
    weak var delegate:  NewsViewModelDelegate?
    var networkManager = NetworkManager()
    var page = 1
    
    func getTopNews() {
        if page == -1 {
            return
        }
        
         self.delegate?.isLoadingTableView(loading: true)
        
        
        networkManager.getTopNews(page: page) { newsResponse, error in
            
            self.delegate?.isLoadingTableView(loading: false)
            if let error = error {
                self.delegate?.showError(message: error)
            }
            if let newsResponse = newsResponse {
                DispatchQueue.main.async {
                
                    if newsResponse.status != "ok" {
                        self.delegate?.showError(message: "Problems with server")
                        return
                    }
                    if newsResponse.articles.count == 0 {
                        self.page = -1
                    }
                    else {
                        if self.page == 1 {
                            self.delegate?.dataLoaded(news: newsResponse.articles)
                        }
                        else {
                            self.delegate?.additionalDataLoaded(news: newsResponse.articles)
                        }
                        self.page += 1
                        
                    }
                }
            }
        }
    }
    
    func getSearchResults(searchString: String) {
        if page == -1 {
            return
        }
         self.delegate?.isLoadingTableView(loading: true)
        networkManager.getSearchResults(page: page, searchString: searchString) { newsResponse, error in
            
            self.delegate?.isLoadingTableView(loading: false)
            if let error = error {
                self.delegate?.showError(message: error)
            }
            if let newsResponse = newsResponse {
                DispatchQueue.main.async {
                
                    if newsResponse.status != "ok" {
                        self.delegate?.showError(message: "Problems with server")
                        return
                    }
                    if newsResponse.articles.count == 0 {
                        self.page = -1
                    }
                    else {
                        if self.page == 1 {
                            self.delegate?.dataLoaded(news: newsResponse.articles)
                        }
                        else {
                            self.delegate?.additionalDataLoaded(news: newsResponse.articles)
                        }
                        self.page += 1
                        
                    }
                }
            }
        }
    }
    
}
