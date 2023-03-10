//
//  UITextView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/13.
//

import UIKit

extension UITextView {
    
    
    //button type별 자간, 폰트 자동화 함수
    func textViewTypeSetting(){

        if let labelText = text, labelText.isEmpty == false {
            
            var attributedString = NSMutableAttributedString(attributedString: attributedText!)
            
            attributedString = addLetterSpacing(attributedString: attributedString)
            attributedString = setTextWithLineHeight(attributedString: attributedString)

            attributedText = attributedString
        }
        
        font = UIFont.nbFont(ofSize: 16, weight: .medium)
        textColor = .black
        
    }
    
    private func addLetterSpacing(attributedString: NSMutableAttributedString) -> NSMutableAttributedString{
        
        attributedString.addAttribute(.kern,
                                      value: 0.32,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length-1))
        
        return attributedString
    }
    
    private func setTextWithLineHeight(attributedString: NSMutableAttributedString) -> NSMutableAttributedString{
        
        let lineHeight: CGFloat = 19.2
        
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight
        
        style.lineSpacing = lineHeight / 4
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
        ]
       
        attributedString.addAttributes(attributes,
                                       range: NSRange(location: 0,
                                                      length: attributedString.length-1))
        return attributedString
    }
    
    func addLetterSpacing(spacing: CGFloat){
        
        if let labelText = text, labelText.isEmpty == false {
            
            let attributedString = NSMutableAttributedString(attributedString: attributedText!)
            
            attributedString.addAttribute(.kern,
                                          value: spacing,
                                          range: NSRange(location: 0,
                                                         length: attributedString.length-1))
            attributedText = attributedString
        }
    }
    
    func setTextWithLineHeight(spaing : CGFloat){
        
        if let labelText = text, labelText.isEmpty == false {
            
            let attributedString = NSMutableAttributedString(attributedString: attributedText!)
            
            let lineHeight: CGFloat = spaing
            
            let style = NSMutableParagraphStyle()
            if let originalStyle = attributedString.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle{
                style.alignment = originalStyle.alignment
            }
            
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            style.lineSpacing = lineHeight / 4
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
            ]
           
            attributedString.addAttributes(attributes,
                                           range: NSRange(location: 0,
                                                          length: attributedString.length-1))
            attributedText = attributedString
        }
    }

}
