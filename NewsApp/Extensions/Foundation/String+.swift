//
//  String+.swift
//  AKV
//
//  Created by Izzatilla on 08.11.2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto
// swiftlint:disable all
extension String {
    
    public func replacingFirstOccurrence(of string: String, with replacement: String) -> String {
        guard let range = self.range(of: string) else {
            return self
        }
        return replacingCharacters(in: range, with: replacement)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with:self)
    }
    
//    func convertToPhoneNum() -> String{
//        let phoneNum = self
//        let s2 = String(format: "+%@ (%@) %@-%@-%@",
//                        phoneNum.substring(to: phoneNum.index(phoneNum.startIndex, offsetBy: 1)),
//                        phoneNum.substring(with: phoneNum.index(phoneNum.startIndex, offsetBy: 1) ..< phoneNum.index(phoneNum.startIndex, offsetBy: 4)),
//                        phoneNum.substring(with: phoneNum.index(phoneNum.startIndex, offsetBy: 4) ..< phoneNum.index(phoneNum.startIndex, offsetBy: 7)),
//                        phoneNum.substring(with: phoneNum.index(phoneNum.startIndex, offsetBy: 7) ..< phoneNum.index(phoneNum.startIndex, offsetBy: 9)),
//                        phoneNum.substring(with: phoneNum.index(phoneNum.startIndex, offsetBy: 9) ..< phoneNum.index(phoneNum.startIndex, offsetBy: 11))
//        )
//        return s2
//    }
    
    func convertToPhoneNumTwo() -> String {
        return self.replacingOccurrences(of: "(.{1})(.{3})(.{4})(.{3})", with: "+$1 ($2) $3-$4", options: .regularExpression, range: nil)
    }
    
    public func trimTrailingWhitespace() -> String {
        if let trailingWs = self.range(of: "\\s+$", options: .regularExpression) {
            return self.replacingCharacters(in: trailingWs, with: "")
        } else {
            return self
        }
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    
    func toDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru")
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    func index(at offset: Int) -> Index? {
        precondition(offset >= 0, "offset can't be negative")
        return index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex))
    }
    func character(at offset: Int) -> Character? {
        precondition(offset >= 0, "offset can't be negative")
        guard let index = index(at: offset) else { return nil }
        return self[index]
    }
    subscript(offset: Int) -> String {
        precondition(offset >= 0, "offset can't be negative")
        guard let character = character(at: offset) else { return "" }
        return String(character)
    }
    subscript(range: Range<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "range lowerBound can't be negative")
        guard let startIndex = index(at: range.lowerBound) else { return "" }
        return self[startIndex..<(index(startIndex, offsetBy: range.count, limitedBy: endIndex) ?? endIndex)]
    }
    subscript(range: ClosedRange<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "range lowerBound can't be negative")
        guard let startIndex = index(at: range.lowerBound) else { return "" }
        return self[startIndex..<(index(startIndex, offsetBy: range.count, limitedBy: endIndex) ?? endIndex)]
    }
    subscript(partialRange: PartialRangeFrom<Int>) -> Substring {
        return self[partialRange.lowerBound..<endIndex.utf16Offset(in: self)]
    }
    subscript(partialRange: PartialRangeUpTo<Int>) -> Substring {
        return self[startIndex.utf16Offset(in: self)..<partialRange.upperBound]
    }
    subscript(partialRange: PartialRangeThrough<Int>) -> Substring {
        return self[startIndex.utf16Offset(in: self)...partialRange.upperBound]
    }
    
}

extension String {
    
    static let serverDateTimeFormat = "yyyy-MM-dd HH:mm:ss"
    
}

extension String {
    
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
    
}

extension String {
    
    mutating func removeLastCharIfPossible() {
        guard !isEmpty else {
            return
        }
        removeLast()
    }
    
}

extension String {
    
    func qrCode(withScale scale: (x: CGFloat, y: CGFloat)) -> UIImage? {
        let data = self.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: scale.x, y: scale.y)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }

    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

extension String {
  func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      preconditionFailure("Take a look to your format")
    }
    return date
  }
}
extension String {
    func substring(_ r: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        let indexRange = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
        return String(self[indexRange])
    }
}
extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
