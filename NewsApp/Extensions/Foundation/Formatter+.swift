//
//  Formatter+.swift
//  AKV
//
//  Created by Nurtugan Nuraly on 12/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}
