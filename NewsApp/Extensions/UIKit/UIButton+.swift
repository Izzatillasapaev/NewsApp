//
//  UIButton+.swift
//  AKV
//
//  Created by Izzatilla on 08.11.2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

extension UIButton {
    func setTitleWithoutAnimation(_ title: String?, for controlState: UIControl.State) {
        UIView.performWithoutAnimation {
            self.setTitle(title, for: controlState)
            self.layoutIfNeeded()
        }
    }
}
