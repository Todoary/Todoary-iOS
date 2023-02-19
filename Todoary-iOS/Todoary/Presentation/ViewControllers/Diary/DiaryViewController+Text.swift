//
//  DiaryViewController+Text.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/30.
//

import UIKit

//MARK: - UITableViewDelegate

extension DiaryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func bindingData(_ diary: DiaryResultModel){
        mainView.diaryTitle.text = diary.title
        mainView.textView.attributedText = diary.content15AttributedString
        mainView.textView.setTextWithLineHeight(spaing: 25)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData.isEmpty ? 1 : todoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if todoData.isEmpty{
            return tableView.dequeueReusableCell(for: indexPath, cellType: NoTodoInDiaryTableViewCell.self)
        }
        
        let todo = todoData[indexPath.row]
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TodoInDiaryTableViewCell.self).then{
            $0.delegate = self
            $0.bindingData(todo)
        }
        return cell
    }
}

//MARK: - UITextViewDelegate

extension DiaryViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        isKeyboardShow = true
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
        
        mainView.borderLine.isHidden = true
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
        isKeyboardShow = false
        mainView.borderLine.isHidden = false
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

//MARK: - API
extension DiaryViewController: DiaryTodoCellDelegate{
    
    func requestPatchTodoCheckStatus(cell: TodoInDiaryTableViewCell){
        
        guard let indexPath = mainView.todoTableView.indexPath(for: cell) else { return }
        let index = indexPath.row
        
        todoData[index].isChecked.toggle()
        let todo = todoData[index]
        
        TodoService.shared.modifyTodoCheckStatus(id: todo.todoId,
                                                 isChecked: todo.isChecked) { result in
            switch result{
            case .success:
                print("DiaryViewController modifyTodoCheckStatus success")
                break
            default:
                print("DiaryViewController modifyTodoCheckStatus fail")
                self.todoData[index].isChecked.toggle()
                break
            }
            
        }
    }
    
    func checkTextValidationAndRequestApi(){
        
        rightButton.isEnabled = false
        
        if(mainView.textView.text == DiaryView.textViewPlaceHolder || mainView.diaryTitle.text!.isEmpty){
            
            let alert = UIAlertController(title: nil, message: "다이어리 제목과 1자 이상의 내용 입력은 필수입니다.", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
            alert.addAction(okBtn)
            
            self.present(alert, animated: true, completion: nil)
        }else{
            requestPostDiary()
        }
    }
    
    private func requestPostDiary(){
        
        let text = NSAttributedString(attributedString: mainView.textView.attributedText)
        let parameter = DiaryRequestModel(title: mainView.diaryTitle.text!,
                                          content: text.attributedString2Html!)
        
        DiaryService.shared.generateDiary(date: pickDate.dateSendServer, request: parameter){ result in
            switch result{
            case .success:
                self.exitBtnDidTab()
                self.navigationController?.popViewController(animated: true)
            default:
                DataBaseErrorAlert.show(in: self)
                self.rightButton.isEnabled = true
                break
                
            }
        }
    }
}

extension DiaryViewController{
    
    //TODO: 메서드 하나로 통일
    @objc func yellowBtnDidClicked(){

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
            
            if(change == UIColor.yellowHighlight){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }else{
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
                attributedString.addAttribute(.backgroundColor,
                                              value: UIColor.yellowHighlight,
                                              range: selectedRange)
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
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor.grayHighlight,
                                          range: selectedRange)
        }
        
        mainView.textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
    }
}
