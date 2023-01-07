//
//  SummaryBottomSheetViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/16.
//

import UIKit

//투두, 다이어리 토스트 뷰 메시지 구분
enum DeleteType: String{
    case Todo = "투두가 삭제되었습니다."
    case Diary = "일기가 삭제되었습니다."
}

class SummaryBottomViewController: UIViewController , UITextFieldDelegate{
    
    //MARK: - UI
    
    let sheetLine = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5/2
    }
    
    var tableView : UITableView!
    
//    let addButton = UIButton().then{
//        $0.backgroundColor = .summaryTitle
//        $0.setImage(UIImage(named: "pencil"), for: .normal)
//        $0.layer.cornerRadius = 70/2
//        $0.layer.shadowRadius = 10.0
//        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
//        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
//        $0.layer.shadowOpacity = 1
//        $0.layer.masksToBounds = false
//        $0.addTarget(self, action: #selector(willMoveDiaryViewController), for: .touchUpInside)
//    }
    
    let todoEasySettingView = UIView().then{
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
    }
    
    let todoTf = UITextField().then{
        $0.isHidden = true
        $0.placeholder = "오늘의 할 일은 무엇인가요?"
        $0.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.addLeftPadding()
        $0.borderStyle = .none
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
        $0.returnKeyType = .done
        $0.enablesReturnKeyAutomatically = true
    }
    
    var collectionView : UICollectionView!
    
    //MARK: - Properties
    
    var categoryData : [GetCategoryResult]! = [] //카테고리 정보 받아오는 struct
    
    var selectCategory: Int = -1 //선택된 카테고리
    var selectCategoryCell: TodoCategoryCell!
    
    var todoEasyTitle : String! //투두간단설정 프로퍼티
    
    var todoDataList : [GetTodoInfo]! = []
    
    var isDiaryExist = false //for 다이어리 작성했을 때 view 구성
    
    var diaryData: GetDiaryInfo?
    
    var todoDate : ConvertDate!
    
    var clampCell : IndexPath = [0,-1] //clamp cell default 값
    
    var homeNavigaiton : UINavigationController!
    
    var addButtonView: AddButtonViewController?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 134/255, green: 182/255, blue: 255/255, alpha: 1)
        
        setInitView()
        setUpView()
        setUpConstraint()
        setUpSheetVC()
        
//        UserDefaults.standard.removeObject(forKey: "accessToken")
//        UserDefaults.standard.removeObject(forKey: "refreshToken")
//        KeyChain.delete(key: Const.UserDefaults.appleIdentifier)
//        KeyChain.delete(key: Const.UserDefaults.appleRefreshToken)
                
    }
    
    //MARK: - Action
    
    @objc
    func cellWillMoveToOriginalPosition(){
        guard let cell = tableView.cellForRow(at: clampCell) as? TodoListTableViewCell else { return }
        cell.cellWillMoveOriginalPosition()
    }
    
    //아무런 todo 없는경우 배너 누르기-> 키보드 올리기
    @objc
    func tapBannerCell(){
        HomeViewController.dismissBottomSheet()
        
        let vc = TodoSettingViewController()
        vc.date.setTitle(todoDate.dateUsedTodo, for: .normal)
        vc.todoDate = todoDate
        
        self.homeNavigaiton.pushViewController(vc, animated: true)
//        self.todoTf.becomeFirstResponder()
    }
    
    //키보드가 올라오는 순간 -> todo간단설정 뷰 보이게
    @objc func didShowKeyboardNotification(_ notification: Notification) {
        var keyboardHeight = 0.0
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                keyboardHeight = keyboardRectangle.height
            }
        
        //constraint 다시 잡아주기
        self.todoEasySettingView.snp.makeConstraints{ make in
            make.height.equalTo(118)
            make.bottom.equalToSuperview().offset(-keyboardHeight)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.todoTf.snp.makeConstraints{ make in
            make.height.equalTo(45)
            make.top.equalTo(self.todoEasySettingView.snp.top).offset(17)
            make.leading.equalTo(todoEasySettingView).offset(32)
            make.trailing.equalTo(todoEasySettingView).offset(-31)
            make.bottom.equalTo(todoEasySettingView.snp.bottom).offset(-56)
        }
        
        self.collectionView.snp.makeConstraints{ make in
            make.height.equalTo(26)
            make.top.equalTo(todoTf.snp.bottom).offset(14)
            make.leading.equalTo(todoEasySettingView).offset(32)
            make.trailing.equalTo(todoEasySettingView.snp.trailing)
            make.bottom.equalTo(todoEasySettingView.snp.bottom).offset(-16)
        }
        
        self.todoEasySettingView.isHidden = false
        self.todoTf.isHidden = false
        self.collectionView.isHidden = false
        
    }
    
    //키보드 내려갈때 todo간단 설정 뷰 안보이게
    @objc func didHideKeyboardNotification(_ notification: Notification) {
        self.todoEasySettingView.isHidden = true
        self.todoTf.isHidden = true
        self.collectionView.isHidden = true
    }
    
    @objc func diaryDeleteBtnDidClicked(){
        
        let alert = CancelAlertViewController(title: "다이어리를 삭제하시겠습니까?")
        alert.alertHandler = {
            DiaryDataManager().delete(createdDate: self.todoDate.dateSendServer)
        }
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)
    }
    
    @objc func willMoveDiaryViewController(){

        let vc = DiaryViewController()

        vc.pickDate = HomeViewController.bottomSheetVC.todoDate
        vc.todoDataList = self.todoDataList
        vc.todaysDate.text = vc.pickDate?.dateUsedDiary

        if(isDiaryExist){
            vc.setUpDiaryData(diaryData!)
        }

        HomeViewController.dismissBottomSheet()
        self.homeNavigaiton.pushViewController(vc, animated: true)
    }
    
    //MARK: - Helper
 
    func getPinnedCount() -> Int{
        
        var count : Int = 0
        
        todoDataList.forEach{ each in
            if (each.isPinned!) {
                count += 1
            }
        }
        return count
    }
    
    func dataArraySortByPin(){
        todoDataList.sort(by: {$0.createdTime < $1.createdTime})
        todoDataList.sort(by: {$0.targetTime ?? "25:00" < $1.targetTime ?? "25:00"})
        todoDataList.sort(by: {$0.isPinned! && !$1.isPinned!})
    }
    
    //todo 간단설정 textfield return 키 누르기 -> 뷰 안보이게 & api 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        todoEasyTitle = todoTf.text!
        
        //제목을 입력하지 않았을 경우
        if todoEasyTitle == "" {
            
            let toast = ToastMessageView(message: "제목을 입력해주세요.")
            
            self.view.addSubview(toast)
            
            toast.snp.makeConstraints{ make in
                make.leading.equalToSuperview().offset(81)
                make.trailing.equalToSuperview().offset(-81)
                make.bottom.equalTo(todoEasySettingView.snp.top).offset(-10)
            }
            
            UIView.animate(withDuration: 1.0, delay: 1.8, options: .curveEaseOut, animations: {
                toast.alpha = 0.0
            }, completion: {(isCompleted) in
                toast.removeFromSuperview()
            })
             
        }else {
            let todoSettingInput = TodoSettingInput(title: todoEasyTitle,
                                                    targetDate: todoDate!.dateSendServer,
                                                    isAlarmEnabled: false,
                                                    targetTime: "",
                                                    categoryId: selectCategory)
            
            TodoSettingDataManager().todoSettingDataManager(self, todoSettingInput)
            self.todoTf.text = ""
            self.selectCategory = categoryData[0].id
            
            GetCalendataManager().getCalendataManager(self, yearMonth: todoDate!.yearMonthSendServer)
            GetDiaryDataManager().getDiaryDataManager(self, yearMonth: todoDate!.yearMonthSendServer)
        }
        
        
        return true
    }
    
    func showDeleteCompleteToastMessage(type: DeleteType){
        
        let toast = ToastMessageView(message: type.rawValue)
        
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
//MARK: - Delegate
extension SummaryBottomViewController: MoveViewController, AddButtonClickProtocol{
    
    func moveToViewController() {

        addButtonView = AddButtonViewController().then{
            $0.delegate = self
            $0.modalPresentationStyle = .overFullScreen
        }
        
        guard let addButtonView = addButtonView else { return }
        
        if(self.sheetPresentationController?.selectedDetentIdentifier == nil || self.sheetPresentationController?.selectedDetentIdentifier?.rawValue == "Test1"){
            addButtonView.detent = .low
        }else{
            addButtonView.detent = .high
        }
        
        self.present(addButtonView, animated: false, completion: nil)
    }
    
    func willMoveAddTodo(){
        
        addButtonView!.dismiss(animated: false, completion: nil)
        
        HomeViewController.dismissBottomSheet()
        
        let vc = TodoSettingViewController()
        vc.date.setTitle(todoDate.dateUsedTodo, for: .normal)
        vc.todoDate = todoDate
        
        self.homeNavigaiton.pushViewController(vc, animated: true)
    }
    
    func willMoveAddDiary(){
        
        addButtonView!.dismiss(animated: false, completion: nil)
        
        let vc = DiaryViewController()

        vc.pickDate = HomeViewController.bottomSheetVC.todoDate
        vc.todoDataList = self.todoDataList
        vc.todaysDate.text = vc.pickDate?.dateUsedDiary

        if(isDiaryExist){
            vc.setUpDiaryData(diaryData!)
        }

        HomeViewController.dismissBottomSheet()
        self.homeNavigaiton.pushViewController(vc, animated: true)
    }
}

//MARK: - API
extension SummaryBottomViewController{
    
    func checkSendCheckboxApiResultCode(indexPath: IndexPath, code: Int){
        switch code{
        case 1000:
            print("체크박스 API 성공")
            todoDataList[indexPath.row - 1].isChecked?.toggle()
            tableView.reloadData()
            return
        default:
            let alert = DataBaseErrorAlert()
            homeNavigaiton.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkGetTodoApiResultCode(_ result: GetTodoModel){

        switch result.code{
        case 1000:
            todoDataList = result.result
            dataArraySortByPin()
            tableView.reloadData()
            todoTf.text = "" //빠른생성 이후 텍스트 필드 초기화
            return
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func checkSendPinApiResultCode(_ code: Int, _ indexPath: IndexPath){
        switch code{
        case 1000:
            print("핀 고정 성공")
            //pin 고정 또는 pin 고정 아니며 핀 고정 개수 초과하지 않은 케이스
            var willChangeData = todoDataList[indexPath.row-1]
            
            willChangeData.isPinned!.toggle()
            todoDataList[indexPath.row-1].isPinned = willChangeData.isPinned
            
            dataArraySortByPin()
        
            guard let newIndex = todoDataList.firstIndex(of: willChangeData) else{ return }
            
            tableView.moveRow(at: indexPath, to: IndexPath(row: newIndex + 1, section: 0))
            tableView.reloadData()
            return
            
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func successAPI_category(_ result : [GetCategoryResult]) {
        if(result.isEmpty){
        }else {
            categoryData = result
            //카테고리 초기값 설정
            if selectCategory == -1{
                selectCategory = categoryData[0].id
            }
            collectionView.reloadData()
        }
    }
    
    func checkTodoDeleteApiResultCode(_ code: Int, _ indexPath: IndexPath){
        switch code{
        case 1000:
            if(todoDataList.count == 1){
                todoDataList = []
                tableView.reloadData()
            }else{
                todoDataList.remove(at: indexPath.row-1)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            showDeleteCompleteToastMessage(type: .Todo)
            
            GetCalendataManager().getCalendataManager(self, yearMonth: todoDate!.yearMonthSendServer)
            
            return
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func checkGetDiaryApiResultCode(_ result: GetDiaryModel){
        switch result.code{
        case 1000:
            isDiaryExist = true
            diaryData = result.result
            tableView.reloadData()
            
            return
        case 2402:
            isDiaryExist = false
            tableView.reloadData()
            return
        default:
            print(result.code)
            print(result.message)
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkDeleteDiaryApiResultCode(_ code: Int){
        switch code{
        case 1000:
            isDiaryExist = false
            tableView.reloadData()
            showDeleteCompleteToastMessage(type: .Diary)
            GetDiaryDataManager().getDiaryDataManager(self, yearMonth: todoDate!.yearMonthSendServer)
            return
        default:
            let alert = DataBaseErrorAlert()
            self.homeNavigaiton.present(alert, animated: true, completion: nil)
            return
        }
    }
}

//MARK: - TableView
extension SummaryBottomViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoDataList.count != 0 ? todoDataList.count + 3 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowCount = tableView.numberOfRows(inSection: 0)
        
        switch indexPath.row{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTitleCell.cellIdentifier, for: indexPath)
                    as? TodoListTitleCell else{ fatalError() }
            cell.navigaiton = homeNavigaiton
            cell.delegate = self
            return cell
        case rowCount - 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTitleCell.cellIdentifier, for: indexPath) as? DiaryTitleCell else{ fatalError() }
            if(isDiaryExist){
                cell.deleteBtn.isHidden = false
                cell.deleteBtn.addTarget(self, action: #selector(diaryDeleteBtnDidClicked), for: .touchUpInside)
            }else{
                cell.deleteBtn.isHidden = true
            }
            return cell
        case rowCount - 1:
            
            //선택한 날짜에 다이어리 존재 여부에 따른 table cell 구성 differ
            if(isDiaryExist){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryCell.cellIdentifier, for: indexPath)
                        as? DiaryCell else{ fatalError()}
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(willMoveDiaryViewController))
                cell.addGestureRecognizer(tapGesture)
                
                if let diaryData = self.diaryData {
                    cell.setUpDataBinding(diaryData)
                }
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: DiaryBannerCell.cellIdentifier, for: indexPath)
                return cell
            }

        default:
            if(todoDataList.count != 0){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.cellIdentifier, for: indexPath)
                        as? TodoListTableViewCell else{ fatalError() }

                cell.navigation = homeNavigaiton
                cell.delegate = self
                cell.cellData = todoDataList[indexPath.row-1]
                cell.cellWillSettingWithData()
                
                return cell
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoBannerCell.cellIdentifier, for: indexPath)
                        as? TodoBannerCell else{ fatalError() }
                
                let tapBannerCell = CellButtonTapGesture(target: self, action: #selector(tapBannerCell))
                tapBannerCell.caller = indexPath.row
                
                cell.navigation = homeNavigaiton
                cell.contentView.addGestureRecognizer(tapBannerCell)
                return cell
            }
        }
    }

}

//MARK: - TableViewCell Delegate
extension SummaryBottomViewController: SelectedTableViewCellDeliver{
    
    func cellWillPin(_ indexPath: IndexPath){
        
        let pinnedCount: Int = getPinnedCount()
        
        let willChangeData = todoDataList[indexPath.row-1]
        let currentPin = willChangeData.isPinned!
    
        if(!currentPin && pinnedCount >= 2){ //pin 상태가 아니지만, 핀 고정 개수 초과
            
            let alert = ConfirmAlertViewController(title: "고정은 2개까지만 가능합니다.")
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: false, completion: nil)
            return
        }
        
        let parameter = TodoPinInput(todoId: willChangeData.todoId, isPinned: !currentPin)
        
        TodoPinDataManager().patch(parameter: parameter, indexPath: indexPath)
    }
    
    func cellWillClamp(_ indexPath: IndexPath){
        
        //1. 기존 고정 cell 존재 여부 점검 (row 값 -1인지 아닌지)
        if(clampCell == indexPath){
            return
        }else if(clampCell.row != -1){
        //2. -1 아닐 경우 -> 이미 고정되어 있는 cell 존재 -> 고정 풀기
            guard let cell = tableView.cellForRow(at: clampCell)
                    as? TodoListTableViewCell else{ return }
            cell.cellWillMoveOriginalPosition()
        }
        //row 값 -1일 때와, row 값 -1 아닐 때 공통 코드(즉, 자기 자신 아닐 때만 제외)
        clampCell = indexPath
    }
    
    func cellDidTapped(_ indexPath: IndexPath) {

        /*
         1. clampCell indexPath 통해 셀 clamp 여부 점검
         2. if clamp 상태 -> originalPosition
         3. if clamp 상태 X -> todoSettingVC 이동
         */
        
        guard let clampCell = tableView.cellForRow(at: clampCell) as? TodoListTableViewCell else { return }
        
        if(!clampCell.isClamp){
            HomeViewController.dismissBottomSheet()
            
            guard let tapCell = tableView.cellForRow(at: indexPath) as? TodoListTableViewCell else { return }
            
            let vc = TodoSettingViewController()
            vc.todoSettingData = tapCell.cellData
            TodoSettingViewController.selectCategory = tapCell.cellData.categoryId
            
            self.homeNavigaiton.pushViewController(vc, animated: true)
        }else{
            clampCell.cellWillMoveOriginalPosition()
        }
    }
    
    func cellWillAlarmEnabled(_ indexPath: IndexPath) {
        
        let alert = AlarmAlertViewController()
        alert.todoData = todoDataList[indexPath.row - 1]
        alert.modalPresentationStyle = .overFullScreen
        
        self.present(alert, animated: false, completion: nil)
    }
}

//MARK: - collectionViewDelegate
extension SummaryBottomViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //TODO: 컬렉션 뷰 셀 selectCategory에 셀 저장
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryData.isEmpty ? 0 : categoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoCategoryCell.cellIdentifier, for: indexPath)
                as? TodoCategoryCell else{ fatalError() }
        
        cell.setBtnAttribute(title: categoryData[indexPath.row].title, color: .categoryColor[ categoryData[indexPath.row].color])
        cell.categoryLabel.layer.borderColor = UIColor.categoryColor[ categoryData[indexPath.row].color].cgColor
        
        if selectCategory == categoryData[indexPath.row].id {
            selectCategoryCell = cell
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
        selectCategory = categoryData[indexPath.row].id
        selectCategoryCell = cell
        cell.categoryLabel.backgroundColor = .categoryColor[categoryData[indexPath.row].color]
        cell.setBtnAttribute(title: categoryData[indexPath.row].title, color: .white)
        cell.categoryLabel.isUserInteractionEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        selectCategoryCell.categoryLabel.backgroundColor = .white
        selectCategoryCell.categoryLabel.layer.borderColor = UIColor.categoryColor[ categoryData[indexPath.row].color].cgColor
        selectCategoryCell.setBtnAttribute(title: categoryData[indexPath.row].title, color: .categoryColor[ categoryData[indexPath.row].color])
        selectCategoryCell.categoryLabel.isUserInteractionEnabled = true
        
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
