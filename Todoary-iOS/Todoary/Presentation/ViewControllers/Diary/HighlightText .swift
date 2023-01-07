//
//  HighlightText .swift
//  Todoary
//
//  Created by 예리 on 2022/08/17.
//

import Foundation
import UIKit

extension UIColor{
    
    static let yellowHighlight = UIColor(
        red: 254/255,
        green: 210/255,
        blue: 90/255,
        alpha: 0.5
    )
    
    static let orangeHighlight = UIColor(
        red: 255/255,
        green: 143/255,
        blue: 84/255,
        alpha: 0.5
    )
    
    static let redHighlight = UIColor(
        red: 234/255,
        green: 44/255,
        blue: 4/255,
        alpha: 0.5
    )
    
    static let greenHighlight = UIColor(
        red: 172/255,
        green: 215/255,
        blue: 134/255,
        alpha: 0.5
    )
    
    static let blueHighlight = UIColor(
        red: 86/255,
        green: 152/255,
        blue: 255/255,
        alpha: 0.5
    )
    
    static let grayHighlight = UIColor(
        red: 184/255,
        green: 184/255,
        blue: 184/255,
        alpha: 0.5
    )
}

extension DiaryViewController{
    
    //엔터키 클릭시 하이라이트 취소 설정 메서드
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            isEnterPressed = true
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if(isEnterPressed){
            
            let selectedRange = self.textView.selectedRange
            let selectedTextRange = self.textView.selectedTextRange

            let customRange: NSRange = NSRange(location: selectedRange.lowerBound-1, length: 1)
            
            let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
            
            attributedString.removeAttribute(.backgroundColor, range: customRange)
            
            textView.attributedText = attributedString
            
            moveCursorEndOfSelection(selectedTextRange)
            
            isEnterPressed = false
        }
    }
    
    func setHighlightToolBarAction(){
    
        self.toolbar.yellowBtn.addTarget(self, action: #selector(yellowBtnDidClicked), for: .touchUpInside)
        self.toolbar.orangeBtn.addTarget(self, action: #selector(orangeBtnDidClicked), for: .touchUpInside)
        self.toolbar.redBtn.addTarget(self, action: #selector(redBtnDidClicked), for: .touchUpInside)
        self.toolbar.greenBtn.addTarget(self, action: #selector(greenBtnDidClicked), for: .touchUpInside)
        self.toolbar.blueBtn.addTarget(self, action: #selector(blueBtnDidClicked), for: .touchUpInside)
        self.toolbar.grayBtn.addTarget(self, action: #selector(grayBtnDidClicked), for: .touchUpInside)
    }
    
    
    @objc func yellowBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        
        if(selectedRange.length == 0){ //글자 드래그로 선택안했을 때 커스텀 불가능 설정
            return
        }
        
        let selectedTextRange = self.textView.selectedTextRange

        let start = selectedRange.lowerBound
        
        let text = textView.text


        let attribute = textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange)


        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)

        if let change = attribute as? UIColor{
            
            if(change == UIColor.yellowHighlight){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }else{
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
                attributedString.addAttribute(.backgroundColor,
                                              value: UIColor.yellowHighlight,
                                              range: selectedRange)
            }
        }
        
        if let value = attribute as? UIColor{
            if(value == UIColor.yellowHighlight) {
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor.yellowHighlight,
                                          range: selectedRange)
        }
        
        textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
    
    @objc func orangeBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        
        if(selectedRange.length == 0){ //글자 드래그로 선택안했을 때 커스텀 불가능 설정
            return
        }
        
        let selectedTextRange = self.textView.selectedTextRange

        let start = selectedRange.lowerBound


        let attribute = textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange)


        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)

        if let change = attribute as? UIColor{
            
            if(change == UIColor.orangeHighlight){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }else{
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
                attributedString.addAttribute(.backgroundColor,
                                              value: UIColor.orangeHighlight,
                                              range: selectedRange)
            }
        }
        
        if let value = attribute as? UIColor{
            if(value == UIColor.orangeHighlight){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor.orangeHighlight,
                                          range: selectedRange)
        }
        
        textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
    
    @objc func redBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        
        if(selectedRange.length == 0){ //글자 드래그로 선택안했을 때 커스텀 불가능 설정
            return
        }
        
        let selectedTextRange = self.textView.selectedTextRange

        let start = selectedRange.lowerBound


        let attribute = textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange)


        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        
        if let change = attribute as? UIColor{
            
            if(change == UIColor.redHighlight){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }else{
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
                attributedString.addAttribute(.backgroundColor,
                                              value: UIColor.redHighlight,
                                              range: selectedRange)
            }
        }

        if let value = attribute as? UIColor{
            if(value == UIColor.redHighlight){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor.redHighlight,
                                          range: selectedRange)
        }
        
        textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
    
    @objc func greenBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        
        if(selectedRange.length == 0){ //글자 드래그로 선택안했을 때 커스텀 불가능 설정
            return
        }
        
        let selectedTextRange = self.textView.selectedTextRange

        let start = selectedRange.lowerBound


        let attribute = textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange)


        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        if let change = attribute as? UIColor{
            
            if(change == UIColor.greenHighlight){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }else{
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
                attributedString.addAttribute(.backgroundColor,
                                              value: UIColor.greenHighlight,
                                              range: selectedRange)
            }
        }


        if let value = attribute as? UIColor{
            if(value ==  UIColor.greenHighlight){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor.greenHighlight,
                                          range: selectedRange)
        }
        
        textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
    
    @objc func blueBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        
        if(selectedRange.length == 0){ //글자 드래그로 선택안했을 때 커스텀 불가능 설정
            return
        }
        
        let selectedTextRange = self.textView.selectedTextRange

        let start = selectedRange.lowerBound


        let attribute = textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange)


        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        if let change = attribute as? UIColor{
            
            if(change == UIColor.blueHighlight){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }else{
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
                attributedString.addAttribute(.backgroundColor,
                                              value: UIColor.blueHighlight,
                                              range: selectedRange)
            }
        }

        if let value = attribute as? UIColor{
            if(value == UIColor.blueHighlight){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor.blueHighlight,
                                          range: selectedRange)
        }
        
        textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
    
    @objc func grayBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        
        if(selectedRange.length == 0){ //글자 드래그로 선택안했을 때 커스텀 불가능 설정
            return
        }
        
        let selectedTextRange = self.textView.selectedTextRange

        let start = selectedRange.lowerBound


        let attribute = textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange)


        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        if let change = attribute as? UIColor{
            
            if(change == UIColor.grayHighlight){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }else{
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
                attributedString.addAttribute(.backgroundColor,
                                              value: UIColor.grayHighlight,
                                              range: selectedRange)
            }
        }

        if let value = attribute as? UIColor{
            if(value == UIColor.grayHighlight){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor.grayHighlight,
                                          range: selectedRange)

        }
        
        textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
}

