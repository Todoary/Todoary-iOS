//
//  UIFont.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/01.
//

import Foundation
import UIKit

enum TextStyles {
    case header
    case subtitle
    case body1
    case body2
    case button1
    case button2
    case subButton
}

enum NBWeight: String {
    case bold = "Bold"
    case semibold = "SemiBold"
    case medium = "Medium"
}

enum FontType: String {
    case apple = "AppleSDGothicNeo"
}

extension UIFont {
    
    static func nbFont(type: TextStyles) -> UIFont {
        switch type {
        case .header:
            return UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)!
        case .subtitle:
            return UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!
        case .body1:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
        case .body2:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
        case .button1:
            return UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)!
        case .button2:
            return UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)!
        case .subButton:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: 10)!
        }
    }
    
    static func nbFont(ofSize fontSize: CGFloat, weight: NBWeight = .medium, type: FontType = .apple) -> UIFont {
        return UIFont(name: "\(type)-\(weight)", size: fontSize)!
    }
    
}
