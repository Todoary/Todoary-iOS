//
//  UILable.swift
//  Todoary
//
//  Created by 예리 on 2022/07/05.
//

import Foundation
import UIKit

//MARK: - UILabel Typo method

extension UILabel {
    
    func setTypoStyle(font: UIFont, kernValue: Double, lineSpacing: CGFloat) {
        if let labelText = text, labelText.count > 0, let attributedText = self.attributedText {

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.maximumLineHeight = lineSpacing
            paragraphStyle.minimumLineHeight = lineSpacing
            
            
             let attributedString = NSMutableAttributedString(attributedString: attributedText)
            
            attributedString.addAttributes([.font:font,
                                                .kern:kernValue,
                                                .paragraphStyle: paragraphStyle,
                                                .baselineOffset: (lineSpacing - font.lineHeight) / 4
            ], range: NSRange(location: 0,
                              length: attributedString.length))
            
            self.attributedText = attributedString
        }
    }
    
    func setTypoStyleWithSingleLine(typoStyle: TypoStyle) {
        
        if(self.text == nil){
            self.text = " "
        }
        
        let font = typoStyle.font
        let kernValue = typoStyle.labelDescription.kern

        if let labelText = text, labelText.count > 0, let attributedText = self.attributedText {
            
             let attributedString = NSMutableAttributedString(attributedString: attributedText)
            
            attributedString.addAttributes([.font:font,
                                            .kern:kernValue],
                                           range: NSRange(location: 0,
                                                          length: attributedString.length))
            
            self.attributedText = attributedString
        }
    }
    
    func setTypoStyleWithMultiLine(typoStyle: TypoStyle) {
        
        if(self.text == nil){
            self.text = " "
        }
        
        let font = typoStyle.font
        let kernValue = typoStyle.labelDescription.kern
        let lineSpacing = typoStyle.labelDescription.lineHeight

        if let labelText = text, labelText.count > 0, let attributedText = self.attributedText {

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.maximumLineHeight = lineSpacing
            paragraphStyle.minimumLineHeight = lineSpacing
            
             let attributedString = NSMutableAttributedString(attributedString: attributedText)
            
            attributedString.addAttributes([.font:font,
                                            .kern:kernValue,
                                            .paragraphStyle: paragraphStyle,
                                            .baselineOffset: (lineSpacing - font.lineHeight) / 4
            ], range: NSRange(location: 0,
                              length: attributedString.length))
            
            self.attributedText = attributedString
        }
    }
}

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
    
    //label 자간, 행간 수동 설정 함수
    func labelAttributeSetting(letterSpacing: Double? = nil, lineHeight: Double? = nil){
        
        if let labelText = text, labelText.isEmpty == false {
            var attributedString = NSMutableAttributedString(attributedString: attributedText!)
            
            if(letterSpacing != nil){
                attributedString = addLetterSpacing(spacing: letterSpacing!, attributedString: attributedString)
            }
            if(lineHeight != nil){
                attributedString = setTextWithLineHeight(lineHeight: lineHeight!, attributedString: attributedString)
            }
            self.attributedText = attributedString
        }
    }
    
    private func setTextWithLineHeight(type: TextStyles,attributedString: NSMutableAttributedString) -> NSMutableAttributedString{
        
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
    
    private func setTextWithLineHeight(lineHeight: Double, attributedString: NSMutableAttributedString) -> NSMutableAttributedString{
        
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight
        style.lineSpacing = lineHeight/4
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
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
    
    private func addLetterSpacing(spacing: Double, attributedString: NSMutableAttributedString) -> NSMutableAttributedString{
        
        attributedString.addAttribute(.kern,
                                      value: spacing,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length-1))
        
        return attributedString
    }
    
    //TODO: - 마무리 때 함수 labelAttributeSetting로 대체하게 하기!!!
    
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
            style.lineSpacing = lineHeight/4
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
//                .baselineOffset: (lineHeight - font.lineHeight) / 4
            ]
            
            let attrString = NSMutableAttributedString(string: text,
                                      attributes: attributes)
            
            self.attributedText = attrString
        }
    }

}

extension UILabel{
    
    func setUnderline() {
        guard let attributedText = self.attributedText else { return }
        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: attributedText.length)
        )
        self.attributedText = attributedString
    }
}

