//
//  UIViewController+.swift
//  AKV
//
//  Created by Izzatilla on 08.11.2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

extension UIViewController {
    class var storyboardId: String {
        return "\(self)"
    }
    func presentFullScreen(vc: UIViewController) {
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    func presentModallyFullScreen(vc: UIViewController) {
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    // swiftlint:disable all
    // MARK: Progress hud
//    func showLoadingHUD() {
//        SVProgressHUD.setDefaultStyle(.custom)
//        SVProgressHUD.setDefaultMaskType(.custom)
//        SVProgressHUD.setForegroundColor(UIColor(named: "buttonRedColor") ?? UIColor.red)           //Ring Color
//        SVProgressHUD.setBackgroundColor(UIColor.white)        //HUD Color
//        SVProgressHUD.setBackgroundLayerColor(UIColor.gray.withAlphaComponent(0.5))
//        SVProgressHUD.show()
//    }
//    
//    func dismissLoadingHUD() {
//        SVProgressHUD.dismiss()
//    }
//    
    func fromSB() -> Self {
        func selfInstance<T>(_ controller: T) -> T {
            let storyboard = UIStoryboard(name: className, bundle: nil)
            if let nVC = storyboard.instantiateInitialViewController() as? UINavigationController {
                return nVC.viewControllers[0] as! T
            } else {
                return storyboard.instantiateInitialViewController() as! T
            }
        }
        return selfInstance(self)
    }
    
    
    // MARK: Alerts
    func showAlert(title: String, messageBody: String) {
        let alert = UIAlertController(title: title, message: messageBody, preferredStyle: .alert)
        let actionClose = UIAlertAction(title: "ОК", style: .default)
        alert.addAction(actionClose)
        self.present(alert, animated: true)
    }
    
    func showAlert(with title: String? = nil, message: String? = nil, style: UIAlertController.Style = .alert, ok: String? = nil, action: (() -> ())? = nil, actions: [UIAlertAction]? = nil) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        var neededActions: [UIAlertAction] = []
        if let ok = ok {
            neededActions = [UIAlertAction(title: ok, style: .default, handler: { _ in action?() })]
        } else if let action = action {
            neededActions = [UIAlertAction(title: "Продолжить", style: .default,
                                           handler: { _ in action() })]
        } else if let actions = actions {
            neededActions = actions
        }
        neededActions.forEach { ac.addAction($0) }
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: Error
    //    func showError(title titleText: String = "Произошла ошибка!", message: String,  complition: (() -> Void)? = nil) {
    //           print("ERROR", message)
    //           let vc = ErrorViewController().fromSB()
    //           vc.modalPresentationStyle = .overCurrentContext
    //           vc.setUp(title: titleText, message: message, complition: complition)
    //           present(vc, animated: false, completion: nil)
    //       }
    //
    func showError(title titleText: String = "Произошла ошибка!", message: String,  complition: (() -> Void)? = nil) {
        print("ERROR", message)
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureContent(title: titleText, body: message)
        view.button?.isHidden = true
        view.configureIcon(withSize: CGSize(width: 50, height: 50), contentMode: .scaleAspectFill)

        SwiftMessages.show(view: view)
//        showSuccess(message: message)
    }
    
    // MARK: Success
    //    func showSuccess(message: String,  complition: (() -> Void)? = nil) {
    //           print("ERROR", message)
    //           let vc = SuccessViewController().fromSB()
    //           vc.modalPresentationStyle = .overCurrentContext
    //           vc.setUp(message: message, complition: complition)
    //           present(vc, animated: false, completion: nil)
    //       }
    func showSuccess(message: String,  complition: (() -> Void)? = nil) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.titleLabel?.isHidden = true
        view.configureContent(body: message)
        view.button?.isHidden = true
        view.configureIcon(withSize: CGSize(width: 50, height: 50), contentMode: .scaleAspectFill)
        
        SwiftMessages.show(view: view)
    }
    
    
    // MARK: Helpers
    func checkIfIphoneX()->Bool{
        if UIDevice().userInterfaceIdiom == .phone {
            let screenHeight = UIScreen.main.nativeBounds.height
            return screenHeight >= 2436 ? true : false
        }
        return false
    }
    
    
}

extension UIViewController {
    
    func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
