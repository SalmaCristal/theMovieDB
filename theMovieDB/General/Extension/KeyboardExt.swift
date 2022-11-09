//
//  KeyboardExt.swift
//  theMovieDB
//
//  Created by Salma Garcia on 07/11/22.
//

import Foundation
import UIKit


struct viewGlobal{
    static var bottomConstraint : NSLayoutConstraint = NSLayoutConstraint()
}

extension UIViewController{ //keyboardHandler
 func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
 }
    func listenerKeyboard(bottomConstraint: NSLayoutConstraint, disabledInPad: Bool = false) {
        if disabledInPad && UIDevice.current.userInterfaceIdiom == .pad {
            return
        }
        viewGlobal.bottomConstraint = bottomConstraint
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
 }
 //Dismiss Keyboard
 @objc func dismissKeyboard() {
    view.endEditing(true)
 }
 @objc func keyboardWillShow(notification:NSNotification) {
    let userInfo:NSDictionary = notification.userInfo! as NSDictionary
    let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
    let keyboardRectangle = keyboardFrame.cgRectValue
    let keyboardHeight = keyboardRectangle.height
    UIView.animate(withDuration: 0.5){
        viewGlobal.bottomConstraint.constant = keyboardHeight
    }
 }

 @objc func keyboardWillHide(notification:NSNotification) {
    UIView.animate(withDuration: 0.5){
        viewGlobal.bottomConstraint.constant = 0
    }
 }
}
