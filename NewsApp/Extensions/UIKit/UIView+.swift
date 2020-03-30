//
//  UIView+.swift
//  AKV
//
//  Created by Izzatilla on 08.11.2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable all
@IBDesignable
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}

@IBDesignable
extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    
    func dropShadow(
        color: UIColor = .black,
        opacity: Float = 0.5,
        offSet: CGSize = CGSize(width: -1, height: 1),
        radius: CGFloat = 1,
        scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = false
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    //MARK: - Shake animation
    func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = -5) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation
        layer.add(animation, forKey: "shake")
    }
    
    public func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = true;
    }
    
}

extension UIView {
    
    func animateWithPulse() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.alpha = 0
        }, completion: nil)
    }
    

    
}


extension UIView {
    
    @discardableResult
    func flipX() -> Self {
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
        return self
    }
    
    @discardableResult
    func flipY() -> Self {
        transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
        return self
    }
    
}

extension UIView {
    
    @discardableResult
    func moveBy(x: CGFloat = 0, y: CGFloat = 0) -> Self {
        frame = CGRect(x: x,
                       y: y,
                       width: frame.width,
                       height: frame.height)
        return self
    }
    
}

extension UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
    
}

// MARK: - Shadow
enum VerticalLocation: String {
    case bottom
    case top
    case left
    case right
    case full
}

extension UIView {
    
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.3, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
             addShadow(offset: CGSize(width: 0, height: 3), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -3), color: color, opacity: opacity, radius: radius)
        case .left:
            addShadow(offset: CGSize(width: -3, height: 0), color: color, opacity: opacity, radius: radius)
        case .right:
            addShadow(offset: CGSize(width: 3, height: 0), color: color, opacity: opacity, radius: radius)
        case .full:
            addShadow(offset: .zero, color: color, opacity: opacity, radius: radius)
        }
    }

    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
extension UIView {

    /// Returns a collection of constraints to anchor the bounds of the current view to the given view.
    ///
    /// - Parameter view: The view to anchor to.
    /// - Returns: The layout constraints needed for this constraint.
    func constraintsForAnchoringTo(boundsOf view: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
}
