//
//  TypoDesignSystem.swift
//  Todoary
//
//  Created by 박소윤 on 2023/01/29.
//

import Foundation

enum Font: String{
    case Bold
    case SemiBold
    case Medium
    case Regular
    case ExtraBold = "EB00"
}

struct FontDescription {
    let font: Font
    let size: CGFloat
}

struct LabelDescription {
    let kern: Double
    let lineHeight: CGFloat
}

enum TypoStyle: Int, CaseIterable {
    case signup_title = 0           // 16pt / bold / 0.32 / 19.2
    case signup_text                // 14pt / semibold / 0.28 / 38.4
    case signup_detail              // 12pt / semibold / 0.36 / 14.4
    
    case setting_menu               // 16pt / medium / 0.32 / 19.2
    
    case account_name               // 18pt / semibold / 0.36 / 21.6
    case account_introduce          // 14pt / medium / 0.28 / 16.8

    case main_nickname              // 14pt / semibold / 0.28 / 16.8
    case main_introduce             // 12pt / medium / 0.24 / 14.4
    
    case main_todoTitle             // 15pt / bold / 0.3 / 18
    case main_category              // 12pt / bold / 0.24 / 14.4
    case main_alarm                 // 13pt / medium / -0.26 / 15.6
    case main_diary_title           // 13pt / extrabold / 0.26 / 15.6
    case main_diary_text            // 12pt / medium / 0.24 / 14.4
    
    case calendar_yearmonth         // 18pt / bold / ? / 21.6
    
    case todo_category              // 14pt / bold / 0.28 / 16.8
    
    case category_todo_line         // 15pt / bold / 0.3 / 22
    case category_edit              // 13pt / bold / 0.26 / 15.6
    case category_setting_todo      // 14pt / semibold / 0.28 / 16.8
    case category_setting_cateogry  // 15pt / medium / 0.3 / 18
    
    case diary_title                // 18pt / bold / 0.36 / 21.6
}

extension TypoStyle {
    private var fontDescription: FontDescription {
        switch self {
        case .signup_title:                 return FontDescription(font: .Bold, size: 16)
        case .signup_text:                  return FontDescription(font: .SemiBold, size: 14)
        case .signup_detail:                return FontDescription(font: .SemiBold, size: 12)
        
        case .setting_menu:                 return FontDescription(font: .Medium, size: 16)
        
        case .account_name:                 return FontDescription(font: .SemiBold, size: 18)
        case .account_introduce:            return FontDescription(font: .Medium, size: 14)
        
        case .main_nickname:                return FontDescription(font: .SemiBold, size: 14)
        case .main_introduce:               return FontDescription(font: .Medium, size: 12)
        
        case .main_todoTitle:               return FontDescription(font: .Bold, size: 15)
        case .main_category:                return FontDescription(font: .Bold, size: 12)
        case .main_alarm:                   return FontDescription(font: .Medium, size: 13)
        case .main_diary_title:             return FontDescription(font: .ExtraBold, size: 13)
        case .main_diary_text:              return FontDescription(font: .Medium, size: 12)
        
        case .calendar_yearmonth:           return FontDescription(font: .Bold, size: 18)
            
        case .todo_category:                return FontDescription(font: .Bold, size: 14)
            
        case .category_todo_line:           return FontDescription(font: .Bold, size: 15)
        case .category_edit:                return FontDescription(font: .Bold, size: 13)
        case .category_setting_todo:        return FontDescription(font: .SemiBold, size: 14)
        case .category_setting_cateogry:    return FontDescription(font: .Medium, size: 15)
            
        case .diary_title:                  return FontDescription(font: .Bold, size: 18)
        }
    }
    
    public var labelDescription: LabelDescription {
        switch self {
        case .signup_title:                 return LabelDescription(kern: 0.32, lineHeight: 19.2)
        case .signup_text:                  return LabelDescription(kern: 0.28, lineHeight: 38.4)
        case .signup_detail:                return LabelDescription(kern: 0.36, lineHeight: 14.4)
        
        case .setting_menu:                 return LabelDescription(kern: 0.32, lineHeight: 19.2)
        
        case .account_name:                 return LabelDescription(kern: 0.36, lineHeight: 21.6)
        case .account_introduce:            return LabelDescription(kern: 0.28, lineHeight: 16.8)
        
        case .main_nickname:                return LabelDescription(kern: 0.28, lineHeight: 16.8)
        case .main_introduce:               return LabelDescription(kern: 0.24, lineHeight: 14.4)
        
        case .main_todoTitle:               return LabelDescription(kern: 0.3, lineHeight: 18)
        case .main_category:                return LabelDescription(kern: 0.24, lineHeight: 14.4)
        case .main_alarm:                   return LabelDescription(kern: -0.26, lineHeight: 15.6)
        case .main_diary_title:             return LabelDescription(kern: 0.26, lineHeight: 15.6)
        case .main_diary_text:              return LabelDescription(kern: 0.24, lineHeight: 14.4)
        
        case .calendar_yearmonth:           return LabelDescription(kern: 0, lineHeight: 21.6)
            
        case .todo_category:                return LabelDescription(kern: 0.28, lineHeight: 16.8)
            
        case .category_todo_line:           return LabelDescription(kern: 0.3, lineHeight: 22)
        case .category_edit:                return LabelDescription(kern: 0.26, lineHeight: 15.6)
        case .category_setting_todo:        return LabelDescription(kern: 0.28, lineHeight: 16.8)
        case .category_setting_cateogry:    return LabelDescription(kern: 0.3, lineHeight: 18)
            
        case .diary_title:                  return LabelDescription(kern: 0.36, lineHeight: 21.6)
        }
    }
}

extension TypoStyle {
    var font: UIFont {
        let dash = self.fontDescription.font == .ExtraBold ? "AppleSDGothicNeo" : "AppleSDGothicNeo-"
        guard let font = UIFont(name: dash + "\(fontDescription.font)", size: fontDescription.size) else {
            return UIFont()
        }
        return font
    }
}
