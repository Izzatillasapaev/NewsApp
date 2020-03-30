//
//  UINavigationBar+.swift
//  AKV
//
//  Created by Izzatilla on 17.11.2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
extension UINavigationBar {
    
    func configure() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.backgroundColor = .white
//        self.setColors(background: .white, text: self.tintColor)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.tintColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.6)
        let backButton = UIBarButtonItem()
//        UIApplication.shared.statusBarStyle = .lightContent
        backButton.title = "Назад"
        backButton.setTitleTextAttributes( [NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium", size: 18)!], for: .normal)
        self.topItem?.backBarButtonItem = backButton
        self.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium", size: 20)!]
    }
    
}
extension UIBarButtonItem {

    static func menuButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true

        return menuBarItem
    }
}
