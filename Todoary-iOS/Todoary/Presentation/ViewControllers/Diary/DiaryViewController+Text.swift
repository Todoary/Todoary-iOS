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
        return todoData.isEmpty ? 1 : todoData.count
    }
    
    func tableView(_ DiaryTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = DiaryTableView.dequeueReusableCell(withIdentifier: DiaryTabelViewCell.cellIdentifier, for: indexPath) as? DiaryTabelViewCell else{
            fatalError()
        }
        
        if todoData.isEmpty{
            cell.titleLabel.text = "오늘은 투두가 없는 널널한 날이네요 *^^*"
            cell.titleLabel.textColor = UIColor(red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
            cell.categoryButton.isHidden = true
            cell.timeLabel.isHidden = true
        }else {
            cell.delegate = self
            cell.cellData = todoData[indexPath.row]
            cell.titleLabel.text = todoData[indexPath.row].title
            cell.timeLabel.text = todoData[indexPath.row].convertTime
            cell.checkBox.isSelected = todoData[indexPath.row].isChecked ?? false
            
            cell.categoryButton.setTitle(todoData[indexPath.row].categoryTitle, for: .normal)
            cell.categoryButton.layer.borderColor = UIColor.categoryColor[todoData[indexPath.row].color].cgColor
            cell.categoryButton.setTitleColor(UIColor.categoryColor[todoData[indexPath.row].color], for: .normal)
            cell.categoryButton.snp.makeConstraints{ make in
                let offset = todoData[indexPath.row].categoryTitle.count == 5 ? 12 : 24
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

extension DiaryViewController: DiaryTodoCellDelegate{
    
    func requestPatchTodoCheckStatus(cell: DiaryTabelViewCell){
        
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
        if(mainView.textView.text == DiaryView.textViewPlaceHolder || mainView.diaryTitle.text!.isEmpty){
            
            let alert = UIAlertController(title: nil, message: "다이어리 제목과 1자 이상의 내용 입력은 필수입니다.", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
            alert.addAction(okBtn)
            
            self.present(alert, animated: true, completion: nil)
        }else{
            
            //TODO: - trimmingCharacters로 공백 및 endline 제거 후, input에 넣기
//            let trimmingText = mainView.textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
            let text = NSAttributedString(attributedString: mainView.textView.attributedText)
        
            
//            let length = mainView.textView.text.count - trimmingText.count
//
//            let text = NSMutableAttributedString(attributedString: mainView.textView.attributedText)
//            text.removeAttribute(.backgroundColor, range: NSRange(location: trimmingText.count, length: length))
            
            let input = DiaryInput(title: mainView.diaryTitle.text!,
                                   content: text.attributedString2Html!)
            
            DiaryDataManager().posts(viewController: self, createdDate: self.pickDate!.dateSendServer, parameter: input)
        }
    }
    
    func setUpDiaryData(_ data: DiaryResultModel){
        self.diary = data
        mainView.diaryTitle.text = diary?.title
        mainView.textView.attributedText = diary?.content15AttributedString
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
