//
//  LoadingScreenViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/08/11.
//

import Foundation
import SnapKit
import UIKit
import Then
import Alamofire

class LoadingHUD: NSObject {
    private static let sharedInstance = LoadingHUD()
    private var popupView: UIImageView?
    private var backgroundView: UIView?

    class func show() {
        let screenSize = UIScreen.main.bounds
        
        let backgroundView = UIView(frame: CGRect.init(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        backgroundView.backgroundColor = .white
        
        let popupView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 71, height: 12))
        popupView.backgroundColor = nil
        popupView.animationImages = LoadingHUD.getAnimationImageArray()
        popupView.animationDuration = 2.0
        popupView.animationRepeatCount = 0

        if let window = UIApplication.shared.keyWindow {
            window.backgroundColor = .white
            window.addSubview(backgroundView)
            window.addSubview(popupView)
            backgroundView.center = window.center
            popupView.center = window.center
            popupView.startAnimating()
            sharedInstance.backgroundView?.removeFromSuperview()
            sharedInstance.popupView?.removeFromSuperview()
            sharedInstance.backgroundView = backgroundView
            sharedInstance.popupView = popupView
        }
    }

    class func hide() {
        if let popupView = sharedInstance.popupView,
           let backgroundView = sharedInstance.backgroundView {
            popupView.stopAnimating()
            popupView.removeFromSuperview()
            backgroundView.removeFromSuperview()
        }
    }

    private class func getAnimationImageArray() -> [UIImage] {
        var animationArray: [UIImage] = []
        animationArray.append(UIImage(named: "loading1")!)
        animationArray.append(UIImage(named: "loading2")!)
        animationArray.append(UIImage(named: "loading3")!)

        return animationArray
    }
}
