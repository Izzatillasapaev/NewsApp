//
//  NewsVC.swift
//  NewsApp
//
//  Created by Izzatilla on 29.03.2020.
//  Copyright © 2020 Izzatilla. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var data: [News] = []
    var viewModel = NewsViewModel()
    var state: NewsState = .topNews
    var searchController: UISearchController!
    var searchString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News"
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        configureSearchBar()
        loadData()
        configureUI()
    }
    
    func configureUI() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = true
    }
    
    func loadData() {
        viewModel.page = 1
        if searchString == "" {
            state = .topNews
        }
        loadNextData()
        
    }
    func loadNextData() {
        switch state {
        case .search:
            viewModel.getSearchResults(searchString: searchString)
        case .topNews:
            viewModel.getTopNews()
        }
    }
    
    private func configureSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        
        if #available(iOS 13, *) {
            searchController.searchBar.delegate = self
        }
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for news"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
}
extension NewsVC: NewsViewModelDelegate {
    
    func isLoadingTableView(loading: Bool) {
        DispatchQueue.main.async {
            self.tableView.tableFooterView?.isHidden = !loading
        }
    }
  
    
    func showError(message: String) {
        self.showError(title: "Error!", message: message)
    }
    
    func dataLoaded(news: [News]) {
        self.data = news
        self.tableView.reloadData()
    }
    
    func additionalDataLoaded(news: [News]) {
        self.data += news
        self.tableView.reloadData()
    }
    
}

extension NewsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.configure(news: data[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch self.state {
            
        case .search:
            return "Search results"
        case .topNews:
            return "Top headlines"
        }
    }
    
}

extension NewsVC: UITableViewDelegate  {
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= data.count - 2 {
            loadNextData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDescribedVC().fromSB()
        vc.news = data[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        state = .topNews
        loadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = searchText
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        state = .search
        loadData()
        
    }
}

enum NewsState {
    case search
    case topNews
}
