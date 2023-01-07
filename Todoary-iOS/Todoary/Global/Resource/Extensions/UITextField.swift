//
//  UITextField.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/04.
//

import UIKit

extension UITextField {

    //placeholder 색상 변경 함수 todoaryGrey
    func setPlaceholderColor(_ placeholderColor: UIColor = .todoaryGrey) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
    
    //button type별 자간, 폰트 자동화 함수
    func textFieldTypeSetting(type: TextStyles = .body2){

        if let labelText = text, labelText.isEmpty == false {
            var attributedString = NSMutableAttributedString(string: labelText)
            attributedString = addLetterSpacing(type: type, attributedString: attributedString)
            
            attributedText = attributedString
        }
        
        font = UIFont.nbFont(type: type)
        textColor = .headline
        setPlaceholderColor()
        
    }
    
    private func addLetterSpacing(type: TextStyles, attributedString: NSMutableAttributedString) -> NSMutableAttributedString{
        
        var value: Double = 0
        
        switch type{
        case .body1, .body2, .acceptTerm:
            value = 0.28
        case .sub1:
            value = 0.36
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
        
        if let labelText = text, labelText.isEmpty == false{
            
            let attributedString = NSMutableAttributedString(string: labelText)
            
            attributedString.addAttribute(.kern,
                                          value: spacing,
                                          range: NSRange(location: 0,
                                                         length: attributedString.length-1))
            
            self.attributedText = attributedString
        }
    }
    
    func addLeftPadding(padding: CGFloat = 10) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
        
    }
}
