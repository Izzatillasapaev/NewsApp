//
//  NewsDescribedVC.swift
//  NewsApp
//
//  Created by Izzatilla on 30.03.2020.
//  Copyright © 2020 Izzatilla. All rights reserved.
//

import UIKit

class NewsDescribedVC: UITableViewController {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var topImageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    
    var news: News!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureData()
        configureUI()
    }
    func configureData() {
        
        if news.urlToImage != nil {
            topImageView.imageFromServerURL(news.urlToImage!)
        }
        if news.author == nil {
            authorLabel.isHidden = true
        }
        //
        titleTextView.text = news.title ?? ""
        descriptionTextView.text = news.description ?? ""
        contentTextView.text = news.content ?? ""
        authorLabel.text = "Author: " + (news.author ?? "")
        publishDateLabel.text = "Published on " + news.getPublishedDate().toString(with: "dd MMMM yyyy 'at' hh:mm")
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        configureUI()
    }
    func configureUI() {
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        titleTextView.sizeToFit()
        descriptionTextView.sizeToFit()
        contentTextView.sizeToFit()
        topImageView.contentMode = .scaleAspectFill
        
        if news.urlToImage == nil {
            topImageHeightConstraint.constant = 0
        }
        self.titleHeightConstraint.constant = self.titleTextView.contentSize.height
        
        self.descriptionHeightConstraint.constant = self.descriptionTextView.contentSize.height
        self.contentHeightConstraint.constant = self.contentTextView.contentSize.height
        
        
        
        //        tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
