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



class LoadingScreenViewController : UIViewController{

    var isTap = false

    override func viewDidLoad() {
        super.viewDidLoad()
        //테스트 할때 써주기
//        LoadingHUD.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class LoadingHUD: NSObject {
    private static let sharedInstance = LoadingHUD()
    private var popupView: UIImageView?

    class func show() {
        let popupView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        popupView.backgroundColor = nil
        popupView.animationImages = LoadingHUD.getAnimationImageArray()
        popupView.animationDuration = 3.0
        popupView.animationRepeatCount = 0

        if let window = UIApplication.shared.keyWindow {
            window.backgroundColor = UIColor.silver_225
            window.addSubview(popupView)
            popupView.center = window.center
            popupView.startAnimating()
            sharedInstance.popupView?.removeFromSuperview()
            sharedInstance.popupView = popupView
        }
    }

    class func hide() {
        if let popupView = sharedInstance.popupView {
            popupView.stopAnimating()
            popupView.removeFromSuperview()
        }
    }

    private class func getAnimationImageArray() -> [UIImage] {
        var animationArray: [UIImage] = []
        animationArray.append(UIImage(named: "password1")!)
        animationArray.append(UIImage(named: "password2")!)
        animationArray.append(UIImage(named: "password3")!)
        animationArray.append(UIImage(named: "password4")!)

        return animationArray
    }
}
