//
//  ColorPickerViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class ColorPickerViewController : BaseViewController, UITextFieldDelegate{
    
    //MARK: - Properties
    
    private var ColorPickerCollectionViewCellid = "ColorPickerCollectionViewCellid"
    
    private var ColorPickerCollectionView: UICollectionView!
    
    //선택된 컬러값
    var selectColor : Int!
    
    //id 데이터가 있을때 카테고리id값
    var categoryId : Int!
    
    //데이터가 넘겨왔을 경우에 data를 담는 struct
    var categoryData : CategoryData!
    
    //카테고리 마지막 하나 남았을때 삭제막기용
    var currentCategoryCount: Int?
    
    let mainView = ColorPickerView()


    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
    }
    
    init(rightButtonTitle: String){
            super.init(nibName: nil, bundle: nil)
            self.setRightButtonWithText(rightButtonTitle)
        }

    init(rightButtonImage: UIImage!){
        super.init(nibName: nil, bundle: nil)
        self.setRightButtonWithImage(rightButtonImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setRightButtonWithText( _ text: String) {
        super.setRightButtonWithText(text)

        self.rightButton.addTarget(self, action: #selector(completeBtnDidTap), for: .touchUpInside)
    }

    override func setRightButtonWithImage( _ image: UIImage!) {
        super.setRightButtonWithImage(image)

        self.rightButton.addTarget(self, action: #selector(deleteBtnDidTap), for: .touchUpInside)
    }
    
    override func style(){
        super.style()
    }
    
    override func layout(){
        
        super.layout()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        
        mainView.categoryTitle.delegate = self
        
        configure()
        setupCollectionView()
        categoryReceive()
        
        rightButton.addTarget(self, action: #selector(completeBtnDidTap), for: .touchUpInside)
        mainView.confirmBtn.addTarget(self, action: #selector(confirmBtnDidTap), for: .touchUpInside)
    }
    
    //MARK: - Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //완료버튼 누르기 -> 뒤로가기, api 호출
    @objc private func completeBtnDidTap() {
        
        //데이터가 없는 경우 생성 api
        //제목이나 컬러값을 유저가 넣지 않았을때 팝업 띄우기
        
        if(selectColor == nil){
            
            let alert = ConfirmAlertViewController(title: "색상을 선택해주세요")
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: false, completion: nil)
            
        }else if(mainView.categoryTitle.text == ""){
            
            let alert = ConfirmAlertViewController(title: "제목을 넣어주세요")
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: false, completion: nil)
            
        }else if(mainView.categoryTitle.text!.count > 5){
            let alert = ConfirmAlertViewController(title: "카테고리명을 5글자 이하로 설정해주세요")
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: false, completion: nil)
            
        }else{
            print(selectColor!)
            let categoryRequest = CategoryModel(title: mainView.categoryTitle.text!, color: selectColor)
            requestGenerateCategory(parameter: categoryRequest)
        }
        
    }
    
    //밑에 위치한 완료버튼을 눌렀을 경우
    @objc private func confirmBtnDidTap() {
        
        //데이터가 있는 경우 수정 api
        //제목이나 컬러값을 유저가 넣지 않았을때 팝업 띄우기
        if(mainView.categoryTitle.text == "" ){
            let alert = ConfirmAlertViewController(title: "제목을 넣어주세요")
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: false, completion: nil)
            
        }else if(mainView.categoryTitle.text!.count > 5){
            
            let alert = ConfirmAlertViewController(title: "카테고리명을 5글자 이하로 설정해주세요.")
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: false, completion: nil)
            
        }else{
            print(selectColor!)
            let categoryRequest = CategoryModel(title: mainView.categoryTitle.text!, color: selectColor)
            requestModifyCategory(id: categoryId, parameter: categoryRequest)
        }
    }
    
    //카테고리 삭제 버튼 -> 카테고리 삭제 api 호출
    @objc func deleteBtnDidTap(){
        
        if(currentCategoryCount == 1){
            
            let alert = ConfirmAlertViewController(title: "카테고리는 최소 1개가 존재해야 합니다")
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: false, completion: nil)
            
        }else{
            requestDeleteCategory(id: categoryId)
        }
    }
    
    //MARK: - API
    func requestGenerateCategory(parameter: CategoryModel){
        CategoryService.shared.generateCategory(request: parameter){ [self] result in
            switch result{
            case .success(let data):
                print("로그: [requestGenerateCategory] success")
                if let categorydata = data as? CategoryResultModel{
                    self.navigationController?.popViewController(animated: true)
                    TodoSettingViewController.selectCategory = (categorydata.categoryId)!
                }
                
                break
            case .invalidSuccess(let code):
                switch code{
                case 2011:
                    let alert = ConfirmAlertViewController(title: "같은 이름의 카테고리가 이미 존재합니다.")
                    alert.modalPresentationStyle = .overFullScreen
                    self.present(alert, animated: false, completion: nil)
                    break
                default:
                    break
                }
            default:
                print("로그: [requestGenerateCategory] fail")
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    func requestModifyCategory(id: Int, parameter: CategoryModel){
        CategoryService.shared.modifyCategory(id: id , request: parameter){ [self] result in
            switch result{
            case .success:
                print("로그: [requestModifyCategory] success")
                self.navigationController?.popViewController(animated: true)
                break
            case .invalidSuccess(let code):
                switch code{
                case 2011:
                    print("로그: [requestModifyCategory] 같은이름의 카테고리가 존재합니다. ")
                    let alert = ConfirmAlertViewController(title: "같은 이름의 카테고리가 이미 존재합니다.")
                    alert.modalPresentationStyle = .overFullScreen
                    self.present(alert, animated: false, completion: nil)
                    break
                default:
                    break
                }
            default:
                print("로그: [requestModifyCategory] fail")
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    func requestDeleteCategory(id: Int){
        CategoryService.shared.deleteCategory(id: id){ [self] result in
            switch result{
            case .success:
                print("로그: [requestDeleteCategory] success")
                TodoSettingViewController.selectCategory = -1
                self.navigationController?.popViewController(animated: true)
                break
            default:
                print("로그: [requestDeleteCategory] fail")
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    //MARK: - Helpers
    
    //정보가 있을 경우에 카테고리정보받아오기
    func categoryReceive(){
        if categoryData != nil {
            mainView.categoryTitle.text = categoryData.title
            categoryId = categoryData.id
            selectColor = categoryData.color
            ColorPickerCollectionView?.reloadData()
        }
    }
    
    //컬렉션뷰 layout
    private func configure() {

           let collectionViewLayer = UICollectionViewFlowLayout()
           collectionViewLayer.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)

        ColorPickerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayer)
        ColorPickerCollectionView.isScrollEnabled = false
        
        view.addSubview(ColorPickerCollectionView)

            ColorPickerCollectionView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(208)
                make.leading.equalToSuperview().offset(50)
                make.width.equalTo(300)
                make.height.equalTo(150)
                make.centerX.equalToSuperview()
           }
       }

    //컬렉션뷰 등록
    private func setupCollectionView() {
        ColorPickerCollectionView.delegate = self
        ColorPickerCollectionView.dataSource = self
        
        ColorPickerCollectionView.register(ColorPickerCollectionViewCell.self, forCellWithReuseIdentifier: ColorPickerCollectionViewCellid)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        print("돼 안돼")
        return true
    }
    
}



    //MARK: - UICollectionViewDataSource

extension ColorPickerViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    //셀 초기값 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ColorPickerCollectionViewCellid,
            for: indexPath) as? ColorPickerCollectionViewCell else {
                fatalError("셀 타입 케스팅 실패")
            }
        
        cell.layer.cornerRadius = 30/2
        cell.backgroundColor = .categoryColor[indexPath.row]
        cell.colorBtnpick.layer.borderColor = UIColor.categoryColor[indexPath.row].cgColor
        
        if(selectColor != nil){
            if indexPath.row == selectColor {
                collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
                cell.isSelected = true
            }
        }
        
        return cell
    }
    
    //셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
    
    //셀 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(25)
    }
    
    //셀 양옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }
    

    
    //MARK: - UICollectionViewDelegate
    
    //셀 선택o
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at:indexPath) as? ColorPickerCollectionViewCell else{
            fatalError()
        }
        selectColor = indexPath.row
        cell.colorBtnpick.isHidden = false
        cell.colorBtnpick.layer.borderWidth = 2
        cell.colorBtnpick.layer.cornerRadius = 40/2
        cell.colorBtnpick.isUserInteractionEnabled = true
    }
    
    //셀 선택x
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


