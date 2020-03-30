//
//  UITableView+.swift
//  AKV
//
//  Created by Izzatilla on 08.11.2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
// swiftlint:disable all
extension UITableView {
    
    func hideUnusedCell() {
        tableFooterView = UIView()
    }
    
    func hide() {
        isHidden = true
    }
    
    func show() {
        isHidden = false
    }
    
    func emptyMessage(message: String,
                      image: UIImage? = UIImage(named: "empty_icon"),
                      frame: CGRect) -> UIView {
        
        let mainView = UIView(frame: frame)
        let screenWidth = mainView.frame.size.width
        let screenHeight = mainView.frame.size.height; // - tabBarHeight
        
        let imageWidth: CGFloat = 100
        let imageHeight: CGFloat = 93
        
        let x = (screenWidth / 2) - (imageWidth / 2)
        let y = (screenHeight / 2) - (imageHeight / 2) - 150
        
        let imageView = UIImageView(frame: CGRect(x: x, y: y, width: imageWidth, height: imageHeight))
        imageView.image = image
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.maxY + 16, width: mainView.bounds.size.width, height: 30))
        messageLabel.center.x = mainView.center.x
        
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        mainView.addSubview(messageLabel)
        mainView.addSubview(imageView)
        
        return mainView
    }
    
    
}
