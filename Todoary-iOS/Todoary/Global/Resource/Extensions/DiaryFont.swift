//
//  DiaryFont.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/12.
//

import Foundation
import UIKit

/*
 1. normal, bold로 타입 구분
 2. currentFont로 현재 폰트 기본값인지 볼드 값인지 구분할 것임
 3.
 */

/*
 
 AppleSDGothicNeo-Medium
 AppleSDGothicNeo-SemiBold
 
 IBMPlexSansKR-Text
 IBMPlexSansKR-Medium
 
 NotoSerifKR-Regular
 NotoSerifKR-SemiBold
 
 IMHyemin-Regular
 IMHyemin-Bold
 
 GangwonEduAllBold
 GangwonEduAllLight
 */

enum DiaryFontType: String{
    case font1 = "AppleSDGothicNeo-"
    case font2 = "IBMPlexSansKR-"
    case font3 = "NotoSerifKR-"
    case font4 = "IMHyemin-"
    case font5 = "GangwonEduAll"
}

enum styleType{
    case normal
    case bold
}

struct DiaryFont{
    
    var fontName: DiaryFontType!
    
    var normal: String?{
        
        let normalValue: String!
        
        switch self.fontName{
        case .font1:
            normalValue = "Medium"
        case .font2:
            normalValue = "Text"
        case .font3:
            normalValue = "Regular"
        case .font4:
            normalValue = "Regular"
        case .font5:
            normalValue = "Light"
        case .none:
            return nil
        }
        return "\(self.fontName.rawValue)\(normalValue!)"
    }
    
    var bold: String?{
        
        let boldValue: String!
        
        switch self.fontName{
        case .font1:
            boldValue = "SemiBold"
        case .font2:
            boldValue = "Medium"
        case .font3:
            boldValue = "SemiBold"
        case .font4:
            boldValue = "Bold"
        case .font5:
            boldValue = "Bold"
        case .none:
            return nil
        }
        return "\(self.fontName.rawValue)\(boldValue!)"
    }
    
    func returnFont(_ style: styleType) -> UIFont?{
        return style == .normal ? UIFont(name: self.normal!, size: 15)! : UIFont(name: self.bold!, size: 15)!
    }
}
