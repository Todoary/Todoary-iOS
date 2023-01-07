//
//  TodoSettingViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/23.
//

import Foundation
import UIKit
import SnapKit
import Then

//TODO: - 수정 사항
/*
 //1. 카테고리 0번째 값으로 초기 세팅
 //2. 카테고리 페이지에서 투두 생성으로 넘어올 경우, 카테고리 세팅한 상태로
 //3. 기존 투두 수정시 카테고리 설정 상태로
 3. 카테고리 필수 선택 팝업 제거
 */

    
class TodoSettingViewController : BaseViewController, AlarmComplete, CalendarComplete , UIGestureRecognizerDelegate{
    
    //카테고리 정보 받아오는 struct
    var categoryData : [GetCategoryResult]! = []
    
    //선택된 카테고리
    static var selectCategory: Int = -1
    
    var dateFormatter = DateFormatter()
    
    var now = Date()
    
    //받아올 정보가 있을때 활성화되는 투두 data
    var todoSettingData : GetTodoInfo!
    
    //받아올 정보가 없을때 활성화 되는 투두 data
    var todoInitData : GetTodoInfo!
    
    var collectionView : UICollectionView!
    
    //선택한 날짜 정보 가져오기
    var todoDate : ConvertDate?
    
    
    //MARK: - UIComponenets
    
    let completeBtn = UIButton().then{
        $0.setTitle("완료", for: .normal)
        $0.addLetterSpacing(spacing: 0.36)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 18, weight: .medium)
        $0.addTarget(self, action: #selector(todocompleteBtnDidTap), for: .touchUpInside)
    }

    
    let todo = UITextField().then{
        $0.placeholder = "투두이름"
        $0.font = UIFont.nbFont(type: .body2)
        $0.setPlaceholderColor(.todoaryGrey)
    }
    
    let todoBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let dateTitle = UILabel().then{
        $0.text = "날짜"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let date = UIButton().then{
        $0.setTitle("2022년 7월 20일", for: .normal)
        $0.addLetterSpacing(spacing: 0.28)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body2)
        $0.titleLabel?.textAlignment = .right
        $0.addTarget(self, action: #selector(dateDidTap), for: .touchUpInside)
    }
    
    let dateBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let alarm = UILabel().then{
        $0.text = "알람"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    var time = UIButton().then{
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.setTitle("AM 8:00", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addLetterSpacing(spacing: 0.28)
        $0.titleLabel?.font = UIFont.nbFont(type: .body2)
        $0.titleLabel?.textAlignment = .right
        $0.addTarget(self, action: #selector(timeDidTap), for: .touchUpInside)
    }
    
    let alarmSwitch = UISwitch().then{
        $0.addTarget(self, action: #selector(onClickSwitch(sender:)), for: .valueChanged)

    }
    
    let alarmBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let category = UILabel().then{
        $0.text = "카테고리"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let plusBtn = UIButton().then{
        $0.setImage(UIImage(named: "categoryadd"), for: .normal)
        $0.addTarget(self, action: #selector(plusBtnDidTap), for: .touchUpInside)
    }
    
    let categoryBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let flowLayout = LeftAlignedCollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = CGFloat(8)
        
        
        //카테고리 컬렉션뷰(수평스크롤)
        collectionView = UICollectionView(frame: .init(), collectionViewLayout: flowLayout).then{
            $0.delegate = self
            $0.dataSource = self
            $0.showsVerticalScrollIndicator = false
            $0.register(TodoCategoryCell.self, forCellWithReuseIdentifier: TodoCategoryCell.cellIdentifier)
        }
        
        setUpView()
        setUpConstraint()
        setupLongGestureRecognizerOnCollection()
        getTodoData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GetCategoryDataManager().getCategoryDataManager(self)
    }
    
    //아무데나 누르기 -> 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Actions
    
    //날짜 누르면 캘린더 바텀시트 띄우기
    @objc func dateDidTap() {
        let todoCalendarBottomSheetVC = TodoCalendarBottomSheetViewController()
        todoCalendarBottomSheetVC.modalPresentationStyle = .overFullScreen
        todoCalendarBottomSheetVC.delegate = self
        //날짜 형식에 맞게 변경 -> 바텀시트 캘린더 열때 적용
        let result = todoSettingData.targetDate.components(separatedBy: "-")
        
        let year : Int? = Int(result[0])
        let month  : Int? = Int(result[1])
        let day : Int? = Int(result[2])
        
        todoCalendarBottomSheetVC.todoYear = year!
        todoCalendarBottomSheetVC.todoMonth = month!
        todoCalendarBottomSheetVC.todoDay = day!
        
        self.present(todoCalendarBottomSheetVC, animated: false, completion: nil)
    }
    
    //시간누르면 알람 바텀시트 띄우기
    @objc func timeDidTap() {
        let todoAlarmBottomSheetVC = TodoAlarmBottomSheetViewController()
        todoAlarmBottomSheetVC.modalPresentationStyle = .overFullScreen
        
        todoAlarmBottomSheetVC.delegate = self
        
        self.present(todoAlarmBottomSheetVC, animated: false, completion: nil)
    }
    
    //완료버튼 누르기 -> 투두생성api 호출 및 성공 시 홈화면 이동
    @objc func todocompleteBtnDidTap() {
        
        //TODO: 투두 글자수 20자 이하 제한 걸기
        if todoSettingData.todoId != -1 {
            
            if(todo.text!.isEmpty){
                
                let alert = ConfirmAlertViewController(title: "제목을 넣어주세요")
                alert.modalPresentationStyle = .overFullScreen
                self.present(alert, animated: false, completion: nil)
                
                
            }else if(todo.text!.count > 20){
                
                let alert = ConfirmAlertViewController(title: "투두를 20자 이하로 설정해주세요")
                alert.modalPresentationStyle = .overFullScreen
                self.present(alert, animated: false, completion: nil)
                
            }else{

                todoSettingData.title = todo.text!
                let todoModifyInput = TodoModifyInput(title: todoSettingData.title,
                                                      targetDate: todoSettingData.targetDate,
                                                      isAlarmEnabled: todoSettingData.isAlarmEnabled,
                                                      targetTime: todoSettingData.targetTime ?? "",
                                                      categoryId: TodoSettingViewController.selectCategory)
                
                TodoModifyDataManager().todoModifyDataManager(self, todoModifyInput, todoId: todoSettingData.todoId)
            }

            
        }else {
            
            if(todo.text!.isEmpty){
                
                let alert = ConfirmAlertViewController(title: "제목을 넣어주세요")
                alert.modalPresentationStyle = .overFullScreen
                self.present(alert, animated: false, completion: nil)
                
            }else if(todo.text!.count > 20){
                let alert = ConfirmAlertViewController(title: "투두를 20자 이하로 설정해주세요")
                alert.modalPresentationStyle = .overFullScreen
                self.present(alert, animated: false, completion: nil)
                
            }else{
                todoSettingData.title = todo.text!
                
                let todoSettingInput = TodoSettingInput(title: todoSettingData.title,
                                                        targetDate: todoSettingData.targetDate,
                                                        isAlarmEnabled: todoSettingData.isAlarmEnabled,
                                                        targetTime: todoSettingData.targetTime ?? "",
                                                        categoryId: TodoSettingViewController.selectCategory)
                TodoSettingDataManager().todoSettingDataManager(self, todoSettingInput)
            }
        }
    }
    
    //카테고리 플러스 버튼 누르기 -> 카테고리 생성 화면
    @objc func plusBtnDidTap() {
        let colorPickerViewController = ColorPickerViewController()
        
        colorPickerViewController.deleteBtn.isHidden = true
        
        self.navigationController?.pushViewController(colorPickerViewController, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //알람 uiswitch 변경 제스쳐
    @objc func onClickSwitch(sender: UISwitch) {
        if sender.isOn {
            time.isHidden = false
            todoSettingData.isAlarmEnabled = true
            todoSettingData.targetTime = "08:00"
            
            let todoAlarmBottomSheetVC = TodoAlarmBottomSheetViewController()
            todoAlarmBottomSheetVC.modalPresentationStyle = .overFullScreen
            todoAlarmBottomSheetVC.delegate = self
            
            self.present(todoAlarmBottomSheetVC, animated: false, completion: nil)
        }else {
            time.isHidden = true
            todoSettingData.targetTime = ""
            todoSettingData.isAlarmEnabled = false
        }
    }
    
    //MARK: - Helpers
    
    //todo 정보 받아오기
    func getTodoData(){
        
        //todoSettingData에 정보가 있을 때
        if todoSettingData != nil{
            
            //받아온 날짜 형식에 맞게 변경
            let result = todoSettingData.targetDate.components(separatedBy: "-")
            
            let year : Int? = Int(result[0])
            let month  : Int? = Int(result[1])
            let day : Int? = Int(result[2])
            date.setTitle(String(year ?? 2022) + "년 " + String(month ?? 08)+"월 " + String(day ?? 01) + "일", for: .normal)
    
            if todoSettingData.targetTime != nil {
                //받아온 시간 형식에 맞게 변경
                dateFormatter.dateFormat = "HH:mm"
                dateFormatter.locale = Locale(identifier: "fr_FR")
                
                //string->date
                let initTime = dateFormatter.date(from: todoSettingData.targetTime!)
                //date->string
                dateFormatter.dateFormat = "a hh:mm"
                dateFormatter.locale = Locale(identifier: "en_US")
                time.setTitle(dateFormatter.string(from: initTime!), for: .normal)
                
                TodoSettingViewController.selectCategory = todoSettingData.categoryId
                
            }
            
            //title설정
            todo.text = todoSettingData.title
            //알람 스위치 설정
            alarmSwitch.isOn = todoSettingData.isAlarmEnabled
            if alarmSwitch.isOn{
                time.isHidden = false
            }else {
                time.isHidden = true
            }
            
            collectionView?.reloadData()
            
        }else { // 없을때
            todoSettingData = GetTodoInfo(todoId: -1,
                                          title: "",
                                          targetDate: "",
                                          isAlarmEnabled: false,
                                          targetTime: "",
                                          createdTime: "",
                                          categoryId: -1,
                                          categoryTitle: "",
                                          color: -1)
            
            if(todoDate != nil){ //요약화면에서 투두 생성할 경우, 타겟 날짜 존재
                date.setTitle(todoDate!.dateUsedTodo, for: .normal)
                todoSettingData.targetDate = todoDate!.dateSendServer
            }else{ //카테고리화면에서 투두 생성할 경우, 타켓 날짜 존재하지 않음 -> 오늘 날짜로 설정
                
                //오늘날짜받아오기
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let today = dateFormatter.string(from: now)
                todoSettingData.targetDate = today
                dateFormatter.dateFormat = "yyyy"
                let year = dateFormatter.string(from: now)
                dateFormatter.dateFormat = "MM"
                let month = Int(dateFormatter.string(from: now))
                dateFormatter.dateFormat = "dd"
                let day = Int(dateFormatter.string(from: now))
                
                
                
                //날짜 초기값 설정(오늘)
                self.date.setTitle("\(year)년 \(month!)월 \(day!)일", for: .normal)
            }
        }
    }
    
    //카테고리 조회 api 성공
    func successAPI_category(_ result : [GetCategoryResult]) {
        if(result.isEmpty){
        }else {
            print("카테고리 목록", result)
            categoryData = result
            //카테고리 초기값 설정
            if TodoSettingViewController.selectCategory == -1{
                TodoSettingViewController.selectCategory = categoryData[0].id
            }
            collectionView.reloadData()
        }
    }
    
    //알람 시간 받아오기
    func alarmComplete(time: String, time_api: String) {
        self.time.setTitle(time, for: .normal)
        self.todoSettingData.targetTime = time_api
    }
    
    //캘린더 날짜 받아오기
    func calendarComplete(date: String, date_api: String) {
        self.date.setTitle(date, for: .normal)
        self.todoSettingData.targetDate = date_api
    }
    
    //길게 누르기 제스쳐 -> 카테고리 수정화면
    func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView?.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }
        
        let p = gestureRecognizer.location(in: collectionView)
        
        if let indexPath = collectionView?.indexPathForItem(at: p) {
            
            let colorPickerViewController = ColorPickerViewController()
            
            colorPickerViewController.currentCategoryCount = categoryData.count
            
            colorPickerViewController.categoryData = CategoryData(id: categoryData[indexPath.row].id, title: categoryData[indexPath.row].title, color: categoryData[indexPath.row].color)
            
            self.navigationController?.pushViewController(colorPickerViewController, animated: true)
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
}



extension TodoSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categoryData.isEmpty{
            return 0
        }else {
            return categoryData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoCategoryCell.cellIdentifier, for: indexPath) as? TodoCategoryCell else{
            fatalError()
        }
        
        cell.setBtnAttribute(title: categoryData[indexPath.row].title, color: .categoryColor[ categoryData[indexPath.row].color])
        cell.categoryLabel.layer.borderColor = UIColor.categoryColor[ categoryData[indexPath.row].color].cgColor
        
        if TodoSettingViewController.selectCategory == categoryData[indexPath.row].id {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            cell.categoryLabel.backgroundColor = .categoryColor[categoryData[indexPath.row].color]
            cell.setBtnAttribute(title: categoryData[indexPath.row].title, color: .white)
            cell.categoryLabel.isUserInteractionEnabled = true
        }else {
            cell.categoryLabel.backgroundColor = .white
            cell.categoryLabel.layer.borderColor = UIColor.categoryColor[ categoryData[indexPath.row].color].cgColor
            cell.setBtnAttribute(title: categoryData[indexPath.row].title, color: .categoryColor[ categoryData[indexPath.row].color])
            cell.categoryLabel.isUserInteractionEnabled = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at:indexPath) as? TodoCategoryCell else{
            fatalError()
        }
        TodoSettingViewController.selectCategory = categoryData[indexPath.row].id
        cell.categoryLabel.backgroundColor = .categoryColor[categoryData[indexPath.row].color]
        cell.setBtnAttribute(title: categoryData[indexPath.row].title, color: .white)
        cell.categoryLabel.isUserInteractionEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at:indexPath) as? TodoCategoryCell else{
            fatalError()
        }
        
        cell.categoryLabel.backgroundColor = .white
        cell.categoryLabel.layer.borderColor = UIColor.categoryColor[ categoryData[indexPath.row].color].cgColor
        cell.setBtnAttribute(title: categoryData[indexPath.row].title, color: .categoryColor[ categoryData[indexPath.row].color])
        cell.categoryLabel.isUserInteractionEnabled = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch categoryData[indexPath.row].title.count {
        case 2:
            return CGSize(width: 53, height: 26)
        case 3:
            return CGSize(width: 66, height: 26)
        case 4:
            return CGSize(width: 79, height: 26)
        case 5:
            return CGSize(width: 92, height: 26)
        default:
            return CGSize(width: 40, height: 26)
        }
    }
}

struct CategoryData {
    var id : Int
    var title : String
    var color : Int
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}
