//
//  UIButton.swift
//  Todoary
//
//  Created by 예리 on 2022/07/05.
//

import Foundation
import UIKit

//MARK: - extension style

extension UIButton {
    
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
    
    //button type별 자간, 폰트 자동화 함수
    func buttonTypeSetting(type: TextStyles){

        if let labelText = titleLabel?.text, labelText.isEmpty == false {
            var attributedString = NSMutableAttributedString(string: labelText)
            attributedString = addLetterSpacing(type: type, attributedString: attributedString)
            
            titleLabel?.attributedText = attributedString
        }
        
        titleLabel?.font = UIFont.nbFont(type: type)
    }
    
    private func addLetterSpacing(type: TextStyles, attributedString: NSMutableAttributedString) -> NSMutableAttributedString{
        
        var value: Double = 0
        
        switch type{
        case .subButton:
            value = 0.3
        default:
            break
        }
        
        attributedString.addAttribute(.kern,
                                      value: value,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length-1))
        
        return attributedString
    }
    
    func addLetterSpacing(spacing: CGFloat){
        
        if let labelText = titleLabel?.text, labelText.isEmpty == false{
            
            let attributedString = NSMutableAttributedString(string: labelText)
            
            attributedString.addAttribute(.kern,
                                          value: spacing,
                                          range: NSRange(location: 0,
                                                         length: attributedString.length-1))
            
            titleLabel?.attributedText = attributedString
        }
    }
    
    
}
