
//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Izzatilla on 29.03.2020.
//  Copyright © 2020 Izzatilla. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImageView.contentMode = .scaleAspectFill
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(news: News) {
        
        if news.urlToImage == nil {
            self.newsImageView.image = UIImage(named: "placeholder")
        }
        else {
            self.newsImageView.imageFromServerURL(news.urlToImage!, placeHolder: UIImage(named: "placeholder"))
        }
        self.titleLabel.text = news.title ?? ""
        self.descriptionLabel.text = news.description ?? ""
    }
}
