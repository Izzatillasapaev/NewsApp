//
//  UIImageView+.swift
//  AKV
//
//  Created by Izzatilla on 17.12.2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Kingfisher
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        var URLString = URLString
       
        if URLString == "" {
            self.image = placeHolder ?? UIImage(named: "placeholder")
        }
        let url = URL(string: URLString)
        if url == nil {
              self.image = placeHolder ?? UIImage(named: "placeholder")
        }
//        let processor = DownsamplingImageProcessor(size: imageView.size)
//                     >> RoundCornerImageProcessor(cornerRadius: 20)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: placeHolder ?? UIImage(named: "defaultHouse"),
            options: [
//                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Image Loading: Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Image Loading: Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        self.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        self.addConstraints([centerX, centerY])
        return activityIndicator
    }
    
    func imageFromServerURL(_ URLString: String) {
      imageFromServerURL(URLString, placeHolder: nil)
    }
}
