//
//  UIColor+.swift
//  AKV
//
//  Created by Izzatilla on 08.11.2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import UIKit
// swiftlint:disable all
extension UIColor {
  
  class func mainApp() -> UIColor{
    return UIColor(red: 251/255, green: 51/255, blue: 83/255, alpha: 1.0)
  }
  
  class func mainColor() -> UIColor{
    return UIColor(red: 251/255, green: 51/255, blue: 83/255, alpha: 1.0)
  }
  
  class func unselectedTextColor() -> UIColor{
    return UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
  }
  
  class func topTabBarbackground() -> UIColor{
    return UIColor(red: 245/255, green: 247/255, blue: 249/255, alpha: 1.0)
  }
  
  class func positiveSum() -> UIColor{
    return UIColor(red: 65/255, green: 117/255, blue: 5/255, alpha: 1.0)
  }
  
  class func negativeSum() -> UIColor{
    return UIColor(red: 251/255, green: 51/255, blue: 83/255, alpha: 1.0)
  }
  
  class func grayBorder() -> UIColor{
    return UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
  }
  
  class func grayPinUnselected() -> UIColor{
    return UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
  }
  
  class func grayBackground() -> UIColor{
    return UIColor(red: 245/255, green: 247/255, blue: 249/255, alpha: 1)
  }
  
  class func separatorColor() -> UIColor{
    return UIColor(red: 219/255, green: 219/255, blue: 219/255, alpha: 1)
  }
  
  class func greenSuccessColor() -> UIColor{
    return #colorLiteral(red: 0.1333333333, green: 0.7098039216, blue: 0.4509803922, alpha: 1)
  }
  
  static var greenColorText: UIColor{
    return UIColor(red:0.13, green:0.71, blue:0.45, alpha:1.0)
  }
  
  
  var whiteness: CGFloat {
    var whiteness: CGFloat = 0
    getWhite(&whiteness, alpha: nil)
    return whiteness
  }
  
  
  var isLight: Bool {
    return whiteness > 0.75
  }
  
  
  func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
    return self.adjust(by: abs(percentage))
  }
  
  /// Darkens a colour by a `percentage`.
  ///
  /// - Parameters:
  ///     - percentage: the amount to darken a colour by.
  ///
  /// - Returns: A colour darkened by a `percentage`.
  ///
  func darker(by percentage: CGFloat = 30.0) -> UIColor? {
    return self.adjust(by: -1 * abs(percentage))
  }
  
  /// Adjusts a colour by a `percentage`.
  ///
  /// Lightening → positive percentage
  ///
  /// Darkening → negative percentage
  ///
  /// - Parameters:
  ///     - percentage: the amount to either lighten or darken a colour by.
  ///
  /// - Returns: A colour either lightened or darkened by a `percentage`.
  ///
  func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
      return UIColor(red: min(red + percentage/100, 1.0),
                     green: min(green + percentage/100, 1.0),
                     blue: min(blue + percentage/100, 1.0),
                     alpha: alpha)
    } else {
      return nil
    }
  }
  
  
  func getPairedColors() -> (UIColor, UIColor) {
    guard whiteness > 0.7 else {
      return (self, (lighter(by: 35) ?? .white))
    }
    return ((darker(by: 35) ?? .black), self)
  }
}

extension String {
  
  func hexColor() -> UIColor? {
    var hexString: String = self.trimmingCharacters(
      in: .whitespacesAndNewlines).uppercased()
    
    if (hexString.hasPrefix("#")) {
      hexString.remove(at: hexString.startIndex)
    }
    
    guard hexString.count == 6 else {
      return nil
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: hexString).scanHexInt64(&rgbValue)
    
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
}

