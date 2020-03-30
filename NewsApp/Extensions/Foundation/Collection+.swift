//
//  Collection+.swift
//  AKV
//
//  Created by Nurtugan Nuraly on 12/9/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
