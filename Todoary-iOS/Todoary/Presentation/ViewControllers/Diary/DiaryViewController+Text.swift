//
//  DiaryViewController+Text.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/30.
//

import UIKit

//MARK: - UITableViewDelegate
extension DiaryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ DiaryTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDataList.isEmpty ? 1 : todoDataList.count
    }
    
    func tableView(_ DiaryTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = DiaryTableView.dequeueReusableCell(withIdentifier: DiaryTabelViewCell.cellIdentifier, for: indexPath) as? DiaryTabelViewCell else{
            fatalError()
        }
        
        if todoDataList.isEmpty{
            cell.titleLabel.text = "오늘은 투두가 없는 널널한 날이네요 *^^*"
            cell.titleLabel.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
            cell.categoryButton.isHidden = true
            cell.timeLabel.isHidden = true
        }else {
            cell.cellData = todoDataList[indexPath.row]
            cell.navigationController = self.navigationController
            cell.titleLabel.text = todoDataList[indexPath.row].title
            cell.timeLabel.text = todoDataList[indexPath.row].convertTime
            cell.checkBox.isSelected = todoDataList[indexPath.row].isChecked ?? false
            
            cell.categoryButton.setTitle(todoDataList[indexPath.row].categoryTitle, for: .normal)
            cell.categoryButton.layer.borderColor = UIColor.categoryColor[todoDataList[indexPath.row].color].cgColor
            cell.categoryButton.setTitleColor(UIColor.categoryColor[todoDataList[indexPath.row].color], for: .normal)
            cell.categoryButton.snp.makeConstraints{ make in
                let offset = todoDataList[indexPath.row].categoryTitle.count == 5 ? 12 : 24
                make.width.equalTo(cell.categoryButton.titleLabel!).offset(offset)
            }
            cell.titleLabel.snp.makeConstraints{ make in
                make.trailing.equalToSuperview().offset(-145)
            }
        }
        
        
        return cell
    }
}

//MARK: - UITextViewDelegate
extension DiaryViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        self.selectedStickerView = nil
        if textView.text == DiaryView.textViewPlaceHolder {
            textView.text = nil
            textView.setTextWithLineHeight(spaing: 25)
            textView.textColor = .black
            textView.font = UIFont.nbFont(ofSize: 15, weight: .medium)
        }
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y -= 275
        }
        
        mainView.diaryLine.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = DiaryView.textViewPlaceHolder
            textView.setTextWithLineHeight(spaing: 25)
            textView.textColor = .silver_225
            textView.font = UIFont.nbFont(ofSize: 15, weight: .medium)
        }
    
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
        
        mainView.diaryLine.isHidden = false
    }
    
    //엔터키 클릭시 하이라이트 취소 설정 메서드
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            isEnterPressed = true
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if(isEnterPressed){
            
            let selectedRange = mainView.textView.selectedRange
            let selectedTextRange = mainView.textView.selectedTextRange

            let customRange: NSRange = NSRange(location: selectedRange.lowerBound-1, length: 1)
            
            let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
            
            attributedString.removeAttribute(.backgroundColor, range: customRange)
            
            textView.attributedText = attributedString
            
            moveCursorEndOfSelection(selectedTextRange)
            
            isEnterPressed = false
        }
    }
}

extension DiaryViewController{
    
    func checkTextValidationAndRequestApi(){
        if(mainView.textView.text == DiaryView.textViewPlaceHolder || mainView.diaryTitle.text!.isEmpty){
            
            let alert = UIAlertController(title: nil, message: "다이어리 제목과 1자 이상의 내용 입력은 필수입니다.", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
            alert.addAction(okBtn)
            
            self.present(alert, animated: true, completion: nil)
        }else{
            let text = NSAttributedString(attributedString: mainView.textView.attributedText)
            
            let input = DiaryInput(title: mainView.diaryTitle.text!,
                                   content: text.attributedString2Html!)
            
            DiaryDataManager().posts(viewController: self, createdDate: self.pickDate!.dateSendServer, parameter: input)
        }
    }
    
    func setUpDiaryData(_ data: GetDiaryInfo){
        self.diaryData = data
        mainView.diaryTitle.text = diaryData?.title
        mainView.textView.attributedText = diaryData?.content15AttributedString
        mainView.textView.setTextWithLineHeight(spaing: 25)
    }
    
    //TODO: 메서드 하나로 통일
    @objc func yellowBtnDidClicked(){

        let selectedRange = mainView.textView.selectedRange
        
        if(selectedRange.length == 0){ //글자 드래그로 선택안했을 때 커스텀 불가능 설정
            return
        }
        
        let selectedTextRange = mainView.textView.selectedTextRange

        let start = selectedRange.lowerBound
        
        let text = mainView.textView.text


        let attribute = mainView.textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &mainView.textView.selectedRange)


        let attributedString = NSMutableAttributedString(attributedString: mainView.textView.attributedText)

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
        
        mainView.textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
    
    @objc func orangeBtnDidClicked(){

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
        
        mainView.textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
    
    @objc func redBtnDidClicked(){

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
        
        mainView.textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
    
    @objc func greenBtnDidClicked(){

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
        
        mainView.textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
    
    @objc func blueBtnDidClicked(){

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
        
        mainView.textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
    
    @objc func grayBtnDidClicked(){

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
        
        mainView.textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
}
