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
    case sub1
    case button1
    case button2
    case subButton
    case numberBtn
    case acceptTerm
    case tableCell
}

enum NBWeight: String {
    case bold = "Bold"
    case semibold = "SemiBold"
    case medium = "Medium"
    case regular = "Regular"
    case extraBold = "EB00"

}

enum FontType: String {
    case apple = "AppleSDGothicNeo"
}

/* 폰트 출력 코드
    for fontFamily in UIFont.familyNames {
        for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
            print(fontName)
        }
    }
 */

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
            return UIFont(name: "AppleSDGothicNeo-Semibold", size: 14)!
        case .sub1:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: 12 )!
        case .button1:
            return UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)!
        case .button2:
            return UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)!
        case .subButton:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: 10)!
        case .numberBtn:
            return UIFont(name: "AppleSDGothicNeo-Bold", size: 26)!
        case .acceptTerm:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
        case .tableCell:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!
        }
    }
    
    static func nbFont(ofSize fontSize: CGFloat, weight: NBWeight = .medium, type: FontType = .apple) -> UIFont {
        if(weight == .extraBold){
            return UIFont(name: "\(type.rawValue)\(weight.rawValue)", size: fontSize)!
        }else{
            return UIFont(name: "\(type.rawValue)-\(weight.rawValue)", size: fontSize)!
        }
    }
    
}
