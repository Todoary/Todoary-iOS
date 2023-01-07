//
//  ToolBarText.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/11.
//

import Foundation
import UIKit

extension DiaryViewController{
    
    func setUpDiaryData(_ data: GetDiaryInfo){
        self.diaryData = data
        self.diaryTitle.text = diaryData?.title
        self.textView.attributedText = diaryData?.content15AttributedString
        self.textView.setTextWithLineHeight(spaing: 25)
    }
    
    func setTextToolBarAction(){
        
        let alignBtnArray = [
            self.toolbar.alignLeftBtn,
            self.toolbar.ailgnCenterBtn, self.toolbar.alignRightBtn]
        
        alignBtnArray.forEach{ each in
            each.addTarget(self, action: #selector(alignBtnDidClicked), for: .touchUpInside)
        }
        
        let lineOrBoldBtnArray = [self.toolbar.strikeLineBtn, self.toolbar.underLineBtn, self.toolbar.boldBtn]
        
        lineOrBoldBtnArray.forEach{ each in
            each.addTarget(self, action: #selector(lineOrBoldBtnDidClicked), for: .touchUpInside)
        }
        
        let fontBtnArray = [self.toolbar.fontBtn1, self.toolbar.fontBtn2, self.toolbar.fontBtn3, self.toolbar.fontBtn4, self.toolbar.fontBtn5]
        
        fontBtnArray.forEach{ each in
            each.addTarget(self, action: #selector(fontChange(_:)), for: .touchUpInside)
        }
        
    }
    
    @objc func alignBtnDidClicked(_ sender: UIButton){
        
        let alignment: NSTextAlignment!
        
        switch sender{
        case self.toolbar.alignLeftBtn:
            alignment = .left
        case self.toolbar.ailgnCenterBtn:
            alignment = .center
        case self.toolbar.alignRightBtn:
            alignment = .right
        default:
            return
        }
        
        self.textView.textAlignment = alignment
    }
    
    @objc
    func fontChange(_ sender: UIButton){
        
        let font: DiaryFontType!
        
        switch sender{
        case self.toolbar.fontBtn1:
            font = .font1
            break
        case self.toolbar.fontBtn2:
            font = .font2
            break
        case self.toolbar.fontBtn3:
            font = .font3
            break
        case self.toolbar.fontBtn4:
            font = .font4
            break
        case self.toolbar.fontBtn5:
            font = .font5
            break
        default:
            return
        }
        
        if(currentFont.fontName == font){
            return
        }
        
        self.currentFont.fontName = font
        self.textView.font = currentFont.returnFont(.normal)
    }
    
    @objc func lineOrBoldBtnDidClicked(_ sender: UIButton){
        
        let selectedRange = self.textView.selectedRange
        
        if(selectedRange.length == 0){ //글자 드래그로 선택안했을 때 커스텀 불가능 설정
            return
        }
        
        let selectedTextRange = self.textView.selectedTextRange
        
        let start = selectedRange.lowerBound
        
        
        var attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        switch sender{
        case self.toolbar.strikeLineBtn:
            attributedString = strikeWillCustom(attributedString: attributedString, start: start, selectedRange: selectedRange)
        case self.toolbar.underLineBtn:
            attributedString = underLineWillCustom(attributedString: attributedString, start: start, selectedRange: selectedRange)
        case self.toolbar.boldBtn:
            attributedString = boldWillCustom(attributedString: attributedString, start: start, selectedRange: selectedRange)
        default:
            return
        }
        
        textView.attributedText = attributedString
        
        moveCursorEndOfSelection(selectedTextRange)
        
    }
    
    @objc
    func strikeWillCustom(attributedString: NSMutableAttributedString, start: Int, selectedRange: NSRange) -> NSMutableAttributedString{

        let attribute = textView.attributedText.attribute(.strikethroughStyle,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange)

        if let value = attribute as? Int{
            if(value == 1){
                attributedString.removeAttribute(.strikethroughStyle, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.strikethroughStyle,
                                          value: 1,
                                          range: selectedRange)
        }
        
        return attributedString
    
    }
    
    @objc
    func underLineWillCustom(attributedString: NSMutableAttributedString, start: Int, selectedRange: NSRange) -> NSMutableAttributedString{

        let attribute = textView.attributedText.attribute(.underlineStyle,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange)

        if let value = attribute as? Int{
            if(value == 1){
                attributedString.removeAttribute(.underlineStyle, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: selectedRange)
        }
        
        return attributedString
    }
    
    @objc
    func boldWillCustom(attributedString: NSMutableAttributedString, start: Int, selectedRange: NSRange) -> NSMutableAttributedString{
        
        let attribute = textView.attributedText.attribute(.font,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange) as? UIFont
        
        var fontStyle: styleType!
        
        if let fontName = attribute?.fontName{
            fontStyle = fontName == currentFont.normal ? .bold : .normal
        }
        
        attributedString.addAttribute(.font,
                                      value: currentFont.returnFont(fontStyle),
                                      range: selectedRange)
        
        return attributedString
    }
    
    //Attribute 추가 후 커서 마지막 드래그 위치로 이동
    func moveCursorEndOfSelection(_ selectedTextRange: UITextRange?){

        if let selectedRange = selectedTextRange {

            if let newPosition = textView.position(from: selectedRange.end, offset: 0) {

                textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
            }
        }
    }


}

extension UITextInput{
    
    var selectedRange: NSRange?{
        if let selectedRange = self.selectedTextRange{
            return NSMakeRange(self.offset(from: self.beginningOfDocument, to: selectedRange.start),
                               self.offset(from: selectedRange.start,to: selectedRange.end))
        }else{
            return nil
        }
    }
}

extension NSAttributedString {
    var attributedString2Html: String? {
        do {
            let htmlData = try self.data(from: NSRange(location: 0, length: self.length), documentAttributes:[.documentType: NSAttributedString.DocumentType.html]);
            return String.init(data: htmlData, encoding: String.Encoding.utf8)
        } catch {
            print("error:", error)
            return nil
        }
    }
}
