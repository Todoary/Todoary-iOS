//
//  CategoryBottomSheetViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/27.
//

import Foundation
import UIKit
import SnapKit
import Then

class CategoryBottomSheetViewController : BaseBottomSheetViewController {
    
    enum State{
        case generate, modify, delete
    }
    
    // MARK: - Properties
    var currentData : CategoryModel?
    var currentCategoryCount: Int? //현재 1개의 카테고리만 존재할 경우 삭제 금지시키기 위한 프로퍼ㅣ
    
    var isKeyboardOpen = false
    var completion: (() -> Void)!
    
    let mainView = CategoryBottomSheetView()
    
    // MARK: - LifeCycle
    
    init(){
        super.init(type: .category)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override
    
    override func viewWillAppear(_ animated: Bool) {
        if let currentData = currentData {
            mainView.colorCollectionView.selectItem(at: [0,currentData.color], animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredVertically)
        }
    }
    
    override func style() {
        super.style()
        self.view.backgroundColor = .calendarSelectColor
    }
    
    override func layout() {
        
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func initialize() {
        
        super.initialize()
        
        mainView.categoryTextField.delegate = self
        mainView.confirmBtn.addTarget(self, action: #selector(confirmBtnDidClicked), for: .touchUpInside)
        mainView.deleteBtn.addTarget(self, action: #selector(deleteCancelBtnDidClicked), for: .touchUpInside)
        
        mainView.colorCollectionView.delegate = self
        mainView.colorCollectionView.dataSource = self
    }
    
    //MARK: - Actions
    
    @objc func confirmBtnDidClicked(){
        
        guard let select = mainView.colorCollectionView.indexPathsForSelectedItems else { return }
        
        guard let categoryText = mainView.categoryTextField.text else{ return }
        
        //카테고리 이름 혹은 색상 선택 안한 경우, 카테고리 생성X
        if(select.isEmpty){
            showToastMessageView("카테고리 색상을 선택해주세요.")
            return
        }else if(categoryText == ""){
            showToastMessageView("카테고리명을 입력해주세요.")
            return
        }else if(categoryText.count > 5){
            showToastMessageView("카테고리명을 5글자 이하로 설정해주세요.")
            return
        }
        
        let color = select[0].row
        
        if(currentData != nil){ //카테고리 수정 API 호출
            
            let parameter = CategoryModel(title: categoryText, color: color)
            
            guard let data = currentData, let categoryId = data.id else { return }
            
            CategoryService.shared.modifyCategory(id: categoryId, request: parameter){ result in
                switch result{
                case .success:
                    self.completion()
                    self.dismiss(animated: true)
                    break
                default:
                    DataBaseErrorAlert.show(in: self)
                    break
                }
            }
            
        }else{ //카테고리 생성 API 호출
            let parameter = CategoryModel(title: categoryText, color: color)
            
            CategoryService.shared.generateCategory(request: parameter){ result in
                switch result{
                case .success:
                    self.completion()
                    self.dismiss(animated: true)
                    break
                case .invalidSuccess(let code):
                    switch code{
                    case 2104:
                        self.showToastMessageView("같은 이름의 카테고리가 이미 존재합니다")
                        break
                    default:
                        break
                    }
                default:
                    DataBaseErrorAlert.show(in: self)
                    break
                }
            }
        }
    }
    
    @objc
    func deleteCancelBtnDidClicked(){
        
        guard let data = currentData, let categoryId = data.id else {
            //버튼: 취소일 경우
            self.dismiss(animated: true)
            return
        }
        //버튼: 삭제일 경우
        let deleteAlert = CancelMessageAlertViewController(title: "카테고리를 삭제하시겠습니까?", message: "카테고리를 삭제할 경우 해당 카테고리와 관련된 투두가 전부 삭제됩니다.")
        deleteAlert.alertHandler = {
            if(self.currentCategoryCount == 1){
                deleteAlert.dismiss(animated: false, completion: nil)
                let alert = ConfirmAlertViewController(title: "카테고리는 최소 1개가 존재해야 합니다")
                alert.modalPresentationStyle = .overFullScreen
                self.present(alert, animated: true, completion: nil)
                
            }else{
                CategoryService.shared.deleteCategory(id: categoryId){ result in
                    switch result{
                    case .success:
                        self.completion()
                        self.dismiss(animated: true)
                        break
                    default:
                        DataBaseErrorAlert.show(in: self)
                        break
                    }
                }
            }
        }
        
        deleteAlert.modalPresentationStyle = .overFullScreen
        self.present(deleteAlert, animated: false, completion: nil)
    }
    
    //MARK: - Helper
    func showToastMessageView(_ message: String){
        
        let toast = ToastMessageView(message: message)
        
        self.view.addSubview(toast)
        
        toast.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(81)
            make.trailing.equalToSuperview().offset(-81)
            make.bottom.equalToSuperview().offset(-39)
        }
        
        UIView.animate(withDuration: 1.0, delay: 1.8, options: .curveEaseOut, animations: {
              toast.alpha = 0.0
          }, completion: {(isCompleted) in
              toast.removeFromSuperview()
          })
        
    }

}

//MARK: - Keyboard
extension CategoryBottomSheetViewController: UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //keyboard 올라와 있을 때, bottomsheet는 종료시키지 않고 키보드만 내리기
        if(isKeyboardOpen){
            self.view.endEditing(true)

            UIView.animate(withDuration: 0.3){
                self.view.window?.frame.origin.y = 0
                self.isKeyboardOpen = false
            }
        }else{
            // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
//            hideBottomSheetAndGoBack()
        }
    }

    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y -= 130
        }
        
        isKeyboardOpen = true
        
        return true
    }
}

//MARK: - UICollectionViewDataSource

extension CategoryBottomSheetViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ColorPickerCollectionViewCell.identifier, for : indexPath) as? ColorPickerCollectionViewCell else {
            fatalError("셀 타입 케스팅 실패")
        }
    
        cell.layer.cornerRadius = 30/2
        cell.backgroundColor = .categoryColor[indexPath.row]
            
        cell.colorBtnpick.layer.borderColor = UIColor.categoryColor[indexPath.row].cgColor
        
        //카테고리 수정인 경우, 초기 카테고리 값 설정 상태로 만들어주기
        if(indexPath.row == currentData?.color){
            cell.colorBtnpick.isHidden = false
            cell.colorBtnpick.layer.borderWidth = 2
            cell.colorBtnpick.layer.cornerRadius = 40/2
            cell.colorBtnpick.isUserInteractionEnabled = true
        }

        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }



//MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at:indexPath) as? ColorPickerCollectionViewCell else{
        fatalError()
        }
        
        cell.colorBtnpick.isHidden = false
        cell.colorBtnpick.layer.borderWidth = 2
        cell.colorBtnpick.layer.cornerRadius = 40/2
        cell.colorBtnpick.isUserInteractionEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at:indexPath) as? ColorPickerCollectionViewCell else{
            fatalError()
        }
        cell.colorBtnpick.isHidden = true
        cell.colorBtnpick.layer.borderWidth = 2
        cell.colorBtnpick.layer.cornerRadius = 40/2
        cell.colorBtnpick.isUserInteractionEnabled = true
    }
}
