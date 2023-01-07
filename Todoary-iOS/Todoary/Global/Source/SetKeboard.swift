//
//  SetKeboard.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/28.
//

import UIKit

extension UIViewController {
    
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            UIView.animate(withDuration: 1){
                if self.view.frame.origin.y == 0{
                    self.view.window?.frame.origin.y -= 20
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            UIView.animate(withDuration: 1){
                self.view.window?.frame.origin.y = 0
            }
        }
    }
    
}

