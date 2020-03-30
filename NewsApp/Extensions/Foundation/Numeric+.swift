//
//  Numeric+.swift
//  AKV
//
//  Created by Nurtugan Nuraly on 12/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
