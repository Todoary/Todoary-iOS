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
    
    case medium12_2             // 12pt / medium / 0.24 / 14.4
    case medium12_3             // 12pt / medium / 0.36 / 14.4
    case medium13               // 13pt / medium / -0.26 / 15.6
    case medium14               // 14pt / medium / 0.28 / 16.8
    case medium15               // 15pt / medium / 0.3 / 18
    case medium16               // 16pt / medium / 0.32 / 19.2
    
    case bold12                 // 12pt / bold / 0.24 / 14.4
    case bold13                 // 13pt / bold / 0.26 / 15.6
    case bold14                 // 14pt / bold / 0.28 / 16.8
    case bold15_18              // 15pt / bold / 0.3 / 18
    case bold15_22              // 15pt / bold / 0.3 / 22
    case bold16                 // 16pt / bold / 0.32 / 19.2
    case bold18                 // 18pt / bold / ? / 21.6
    case bold18_2               // 18pt / bold / 0.36 / 21.6
    
    case semibold14             // 14pt / semibold / 0.28 / 16.8
    case semibold18             // 18pt / semibold / 0.36 / 21.6

    case extrabold13            // 13pt / extrabold / 0.26 / 15.6
}

extension TypoStyle {
    private var fontDescription: FontDescription {
        switch self {
        case .medium12_2:               return FontDescription(font: .Medium, size: 12)
        case .medium12_3:               return FontDescription(font: .Medium, size: 12)
        case .medium13:                 return FontDescription(font: .Medium, size: 13)
        case .medium14:                 return FontDescription(font: .Medium, size: 14)
        case .medium15:                 return FontDescription(font: .Medium, size: 15)
        case .medium16:                 return FontDescription(font: .Medium, size: 16)
        
            

        case .bold12:                   return FontDescription(font: .Bold, size: 12)
        case .bold13:                   return FontDescription(font: .Bold, size: 13)
        case .bold14:                   return FontDescription(font: .Bold, size: 14)
        case .bold15_18:                return FontDescription(font: .Bold, size: 15)
        case .bold15_22:                return FontDescription(font: .Bold, size: 15)
        case .bold16:                   return FontDescription(font: .Bold, size: 16)
        case .bold18:                   return FontDescription(font: .Bold, size: 18)
        case .bold18_2:                 return FontDescription(font: .Bold, size: 18)
            
            
        case .semibold14:               return FontDescription(font: .SemiBold, size: 14)
        case .semibold18:               return FontDescription(font: .SemiBold, size: 18)
        
        case .extrabold13:              return FontDescription(font: .ExtraBold, size: 13)
        }
    }
    
    public var labelDescription: LabelDescription {
        switch self {
        case .medium12_2:               return LabelDescription(kern: 0.24, lineHeight: 14.4)
        case .medium12_3:               return LabelDescription(kern: 0.36, lineHeight: 14.4)
        case .medium13:                 return LabelDescription(kern: -0.26, lineHeight: 15.6)
        case .medium14:                 return LabelDescription(kern: 0.28, lineHeight: 16.8)
        case .medium15:                 return LabelDescription(kern: 0.3, lineHeight: 18)
        case .medium16:                 return LabelDescription(kern: 0.32, lineHeight: 19.2)
        
        case .bold12:                   return LabelDescription(kern: 0.24, lineHeight: 14.4)
        case .bold13:                   return LabelDescription(kern: 0.26, lineHeight: 15.6)
        case .bold14:                   return LabelDescription(kern: 0.28, lineHeight: 16.8)
        case .bold15_18:                return LabelDescription(kern: 0.3, lineHeight: 18)
        case .bold15_22:                return LabelDescription(kern: 0.3, lineHeight: 22)
        case .bold16:                   return LabelDescription(kern: 0.32, lineHeight: 19.2)
        case .bold18:                   return LabelDescription(kern: 0, lineHeight: 21.6)
        case .bold18_2:                 return LabelDescription(kern: 0.36, lineHeight: 21.6)
        
        case .semibold14:               return LabelDescription(kern: 0.28, lineHeight: 16.8)
        case .semibold18:               return LabelDescription(kern: 0.36, lineHeight: 21.6)
        
        case .extrabold13:              return LabelDescription(kern: 0.26, lineHeight: 15.6)
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
