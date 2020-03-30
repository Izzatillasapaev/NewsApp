//
//  NSObject+.swift
//  AKV
//
//  Created by Izzatilla on 08.11.2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
}
