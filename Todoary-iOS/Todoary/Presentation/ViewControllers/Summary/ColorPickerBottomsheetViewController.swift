//
//  ColorPickerBottomsheetViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/27.
//

import Foundation
import UIKit
import SnapKit
import Then

class ColorPickerBottomsheetViewController : UIViewController {
    // MARK: - Properties
    var currentData : GetCategoryResult?
    
    var currentCategoryCount: Int? //현재 1개의 카테고리만 존재할 경우 삭제 금지시키기 위한 프로퍼ㅣ
    
    var isKeyboardOpen = false

    //바텀시트 높이
    let bottomHeight : CGFloat = 342
    
    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    private var ColorPickerBottomsheetCollectionViewcellid = "ColorPickerBottomsheetCollectionViewcellid"
    
    private var ColorPickerBottomsheetCollectionView: UICollectionView!
    
    var categoryVC: CategoryViewController!
    
    // MARK: - UIComponents
    
    let dimmedBackView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    let bottomSheetView = UIView().then {
        $0.backgroundColor = .calendarSelectColor
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    let categoryTextField = UITextField().then {
        $0.placeholder = "카테고리 이름을 입력해주세요"
        $0.font = UIFont.nbFont(ofSize: 13, weight: .bold)
        $0.setPlaceholderColor(.todoaryGrey)
        $0.addLeftPadding(padding: 17)
        //그림자
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    lazy var confirmBtn = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addLetterSpacing(spacing: 0.3)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
        $0.addTarget(self, action: #selector(confirmBtnDidClicked), for: .touchUpInside)
    }
    
    lazy var deleteBtn = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addLetterSpacing(spacing: 0.3)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
        $0.addTarget(self, action: #selector(deleteCancelBtnDidClicked), for: .touchUpInside)
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpConstraint()
        setupGestureRecognizer()
        
        categoryTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if let currentData = currentData {
            ColorPickerBottomsheetCollectionView.selectItem(at: [0,currentData.color], animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredVertically)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
    
    // MARK: - Layout
    private func setUpView() {
        
        view.addSubview(dimmedBackView)
        view.addSubview(bottomSheetView)
        
        view.addSubview(categoryTextField)
        
        view.addSubview(confirmBtn)
        view.addSubview(deleteBtn)
        
        dimmedBackView.alpha = 0.0
        setUpConstraint()
        
        configure()
        setupCollectionView()
    }
    
    private func setUpConstraint() {
        dimmedBackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmedBackView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
            
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint
        ])
        
        categoryTextField.snp.makeConstraints{ make in
            make.top.equalTo(bottomSheetView.snp.top).offset(30)
            make.centerX.equalTo(bottomSheetView)
            make.width.equalTo(328)
            make.height.equalTo(46)
            
        }
        
        confirmBtn.snp.makeConstraints{ make in
            make.top.equalTo(bottomSheetView.snp.top).offset(270)
            make.leading.equalTo(bottomSheetView.snp.leading).offset(66)
            make.width.equalTo(93)
            make.height.equalTo(38)
            
        }
        
        deleteBtn.snp.makeConstraints{ make in
            make.top.equalTo(bottomSheetView.snp.top).offset(270)
            make.trailing.equalTo(bottomSheetView.snp.trailing).offset(-66)
            make.width.equalTo(93)
            make.height.equalTo(38)
        }
    }
    
    //MARK: - Actions
    
    @objc
    func confirmBtnDidClicked(){
        
        guard let select = ColorPickerBottomsheetCollectionView.indexPathsForSelectedItems else { return }
        
        guard let categoryText = categoryTextField.text else{ return }
        
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
        
        //TODO: - Code Refactor
        
        if(currentData != nil){ //카테고리 수정 API 호출
            let parameter = CategoryModifyInput(title: categoryText, color: color)
            
            guard let data = currentData else { return }
            
            CategoryModifyDataManager().patch(categoryId: data.id, parameter: parameter, viewController: self, categoryViewController: categoryVC)
            
        }else{ //카테고리 생성 API 호출
            let parameter = CategoryMakeInput(title: categoryText, color: color)
            
            CategoryMakeDataManager().categoryMakeDataManager(parameter: parameter, categoryVC: categoryVC, viewController: self)
        }
    }
    
    @objc
    func deleteCancelBtnDidClicked(){
        
        guard let data = currentData else {
            //버튼: 취소일 경우
            hideBottomSheetAndGoBack()
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
                CategoryDeleteDataManager().delete(categoryId: data.id, viewController: self, categoryViewController: self.categoryVC)
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
    
    
    //MARK: - Helpers_BottomSheet
    
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.1
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
    @objc
    func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    // GestureRecognizer 세팅 작업
    private func setupGestureRecognizer() {
        
        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }

    
    // UISwipeGestureRecognizer 연결 함수 부분
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                //keyboard 올라와 있을 때, bottomsheet는 종료시키지 않고 키보드만 내리기
                if(isKeyboardOpen){
                    self.view.endEditing(true)

                    UIView.animate(withDuration: 0.3){
                        self.view.window?.frame.origin.y = 0
                        self.isKeyboardOpen = false
                    }
                }else{
                    // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
                    hideBottomSheetAndGoBack()
                }
            default:
                break
            }
        }
    }
    
    //MARK: - Helpers_ColorPicker
    
    private func configure() {
        let collectionViewLayer = UICollectionViewFlowLayout()
        collectionViewLayer.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)

        ColorPickerBottomsheetCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayer)
        ColorPickerBottomsheetCollectionView.isScrollEnabled = false
        ColorPickerBottomsheetCollectionView.backgroundColor = .transparent
        
        view.addSubview(ColorPickerBottomsheetCollectionView)

        ColorPickerBottomsheetCollectionView.snp.makeConstraints { make in
                make.top.equalTo(bottomSheetView).offset(102)
                make.leading.equalTo(bottomSheetView).offset(45)
                make.width.equalTo(290)
                make.height.equalTo(150)
                make.centerX.equalTo(bottomSheetView)
           }
       }

    
    private func setupCollectionView() {
        ColorPickerBottomsheetCollectionView.delegate = self
        ColorPickerBottomsheetCollectionView.dataSource = self
        
        //cell 등록
        ColorPickerBottomsheetCollectionView.register(ColorPickerCollectionViewCell.self, forCellWithReuseIdentifier: ColorPickerBottomsheetCollectionViewcellid)
        
    }

}

//MARK: - Keyboard
extension ColorPickerBottomsheetViewController: UITextFieldDelegate{
    
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
            hideBottomSheetAndGoBack()
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



extension ColorPickerBottomsheetViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ColorPickerBottomsheetCollectionViewcellid, for : indexPath) as? ColorPickerCollectionViewCell else {
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





