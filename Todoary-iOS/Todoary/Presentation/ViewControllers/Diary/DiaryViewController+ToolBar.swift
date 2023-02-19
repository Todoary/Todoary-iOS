//
//  DiaryViewController+ToolBar.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/30.
//

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
    
    @objc func colorHighlightButtonDidTapped(_ sender: UIButton){
        
        let selectedRange = mainView.textView.selectedRange
        if(selectedRange.length == 0){ //글자 드래그로 선택안했을 때 커스텀 불가능 설정
            return
        }
        
        let selectedTextRange = mainView.textView.selectedTextRange
        let start = selectedRange.lowerBound
        let attribute = mainView.textView.attributedText.attribute(.backgroundColor,
                                                                at: start,
                                                                   effectiveRange: &mainView.textView.selectedRange)

        let attributedString = NSMutableAttributedString(attributedString: mainView.textView.attributedText)
        let color = sender.backgroundColor!.withAlphaComponent(0.5)

        if let change = attribute as? UIColor{
            attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            if(change != color){
                attributedString.addAttribute(.backgroundColor,
                                              value: color,
                                              range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: color,
                                          range: selectedRange)
        }
        
        mainView.textView.attributedText = attributedString
        moveCursorEndOfSelection(selectedTextRange)
    }
}


extension DiaryViewController {
    
    @objc func cameraBtnTab() {
        
        mainView.textView.inputView = nil
        mainView.textView.endEditing(true)
        mainView.textView.reloadInputViews()
        
        let alert = ConfirmMessageAlertViewController(title: "다음 업데이트에 만나요!", message: "현재 버전에서는 제공하고 있지 않은 기능입니다.")
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)
    }
    
    
    @objc func textBtnTab() {
        mainView.textView.inputView = nil
        mainView.textView.reloadInputViews()
    }
    
    @objc func stickerBtnTab() {
        mainView.textView.inputView = DiarySticker
        mainView.toolbar.textToolbar.isHidden = true
        mainView.toolbar.colorToolbar.isHidden = true
        mainView.toolbar.fontToolbar.isHidden = true
        mainView.textView.reloadInputViews()
        setupGestureRecognizerOnCollection()
    }
    
    @objc func highlightBtnTab() {
        mainView.textView.inputView = nil
        mainView.textView.reloadInputViews()
    }
    
    @objc func exitBtnDidTab() {
        mainView.toolbar.textToolbar.isHidden = true
        mainView.toolbar.fontToolbar.isHidden = true
        mainView.toolbar.colorToolbar.isHidden = true
        mainView.textView.inputView = nil
        mainView.textView.endEditing(true)
        mainView.textView.reloadInputViews()
    }
    
    func setTextToolBarAction(){
        
        let alignBtnArray = [
            mainView.toolbar.alignLeftBtn,
            mainView.toolbar.ailgnCenterBtn, mainView.toolbar.alignRightBtn]
        
        alignBtnArray.forEach{ each in
            each.addTarget(self, action: #selector(alignBtnDidClicked), for: .touchUpInside)
        }
        
        let lineOrBoldBtnArray = [mainView.toolbar.strikeLineBtn, mainView.toolbar.underLineBtn, mainView.toolbar.boldBtn]
        
        lineOrBoldBtnArray.forEach{ each in
            each.addTarget(self, action: #selector(lineOrBoldBtnDidClicked), for: .touchUpInside)
        }
        
        let fontBtnArray = [mainView.toolbar.fontBtn1, mainView.toolbar.fontBtn2, mainView.toolbar.fontBtn3, mainView.toolbar.fontBtn4, mainView.toolbar.fontBtn5]
        
        fontBtnArray.forEach{ each in
            each.addTarget(self, action: #selector(fontChange(_:)), for: .touchUpInside)
        }
        
    }
    
    @objc func alignBtnDidClicked(_ sender: UIButton){
        
        let alignment: NSTextAlignment!
        
        switch sender{
        case mainView.toolbar.alignLeftBtn:
            alignment = .left
        case mainView.toolbar.ailgnCenterBtn:
            alignment = .center
        case mainView.toolbar.alignRightBtn:
            alignment = .right
        default:
            return
        }
        
        mainView.textView.textAlignment = alignment
    }
    
    @objc
    func fontChange(_ sender: UIButton){
        
        let font: DiaryFontType!
        
        switch sender{
        case mainView.toolbar.fontBtn1:
            font = .font1
            break
        case mainView.toolbar.fontBtn2:
            font = .font2
            break
        case mainView.toolbar.fontBtn3:
            font = .font3
            break
        case mainView.toolbar.fontBtn4:
            font = .font4
            break
        case mainView.toolbar.fontBtn5:
            font = .font5
            break
        default:
            return
        }
        
        if(currentFont.fontName == font){
            return
        }
        
        self.currentFont.fontName = font
        mainView.textView.font = currentFont.returnFont(.normal)
    }
    
    @objc func lineOrBoldBtnDidClicked(_ sender: UIButton){
        
        let selectedRange = mainView.textView.selectedRange
        
        if(selectedRange.length == 0){ //글자 드래그로 선택안했을 때 커스텀 불가능 설정
            return
        }
        
        let selectedTextRange = mainView.textView.selectedTextRange
        
        let start = selectedRange.lowerBound
        
        
        var attributedString = NSMutableAttributedString(attributedString: mainView.textView.attributedText)
        
        switch sender{
        case mainView.toolbar.strikeLineBtn:
            attributedString = strikeWillCustom(attributedString: attributedString, start: start, selectedRange: selectedRange)
        case mainView.toolbar.underLineBtn:
            attributedString = underLineWillCustom(attributedString: attributedString, start: start, selectedRange: selectedRange)
        case mainView.toolbar.boldBtn:
            attributedString = boldWillCustom(attributedString: attributedString, start: start, selectedRange: selectedRange)
        default:
            return
        }
        
        mainView.textView.attributedText = attributedString
        
        moveCursorEndOfSelection(selectedTextRange)
        
    }
    
    @objc
    func strikeWillCustom(attributedString: NSMutableAttributedString, start: Int, selectedRange: NSRange) -> NSMutableAttributedString{

        let attribute = mainView.textView.attributedText.attribute(.strikethroughStyle,
                                                          at: start,
                                                          effectiveRange: &mainView.textView.selectedRange)

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

        let attribute = mainView.textView.attributedText.attribute(.underlineStyle,
                                                          at: start,
                                                          effectiveRange: &mainView.textView.selectedRange)

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
        
        let attribute = mainView.textView.attributedText.attribute(.font,
                                                          at: start,
                                                          effectiveRange: &mainView.textView.selectedRange) as? UIFont
        
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

            if let newPosition = mainView.textView.position(from: selectedRange.end, offset: 0) {

                mainView.textView.selectedTextRange = mainView.textView.textRange(from: newPosition, to: newPosition)
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
