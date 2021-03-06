//
//  UILable.swift
//  Todoary
//
//  Created by 예리 on 2022/07/05.
//

import Foundation
import UIKit

extension UILabel {
    
    //label type별 자간, 행간, 폰트 자동화 함수
    func labelTypeSetting(type: TextStyles){
        
        if let labelText = text, labelText.isEmpty == false {
            var attributedString = NSMutableAttributedString(string: labelText)
            attributedString = addLetterSpacing(type: type, attributedString: attributedString)
            attributedString = setTextWithLineHeight(type: type, attributedString: attributedString)
            
            self.attributedText = attributedString
        }
        self.font = UIFont.nbFont(type: type)
    }
    
    private func setTextWithLineHeight(type: TextStyles, attributedString: NSMutableAttributedString) -> NSMutableAttributedString{
        
        var lineHeight: Double = 0
        
        switch type {
        case .header:
            lineHeight = 21.6
            break
        case .subtitle, .tableCell:
            lineHeight = 19.2
            break
        case .body1, .body2:
            lineHeight = 16.8
            break
        case .sub1:
            lineHeight = 14.4
            break
        case .acceptTerm:
            lineHeight = 21
        default:
            return attributedString
        }
        
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .baselineOffset: (lineHeight - font.lineHeight) / 4
        ]
        
        attributedString.addAttributes(attributes, range: NSRange(location: 0,
                                                                  length: attributedString.length-1))
        return attributedString
    }
    
    private func addLetterSpacing(type: TextStyles, attributedString: NSMutableAttributedString) -> NSMutableAttributedString{
        
        var value: Double = 0
        
        switch type{
        case .body1, .body2, .acceptTerm:
            value = 0.28
        case .sub1:
            value = 0.36
        case .tableCell:
            value = 0.32
        default:
            break
        }
        
        attributedString.addAttribute(.kern,
                                      value: value,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length-1))
        
        return attributedString
    }
    
    //기본 타입 아닌 경우 자간 설정 함수
    func addLetterSpacing(spacing: CGFloat){
        
        if let labelText = text, labelText.isEmpty == false{
            
            let attributedString = NSMutableAttributedString(string: labelText)
            
            attributedString.addAttribute(.kern,
                                          value: spacing,
                                          range: NSRange(location: 0,
                                                         length: attributedString.length-1))
            
            self.attributedText = attributedString
        }
    }
    
    //기본 타입 아닌 경우 행간 설정 함수
    func setTextWithLineHeight(lineHeight: CGFloat){
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 4
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }

}



