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

class SummaryBottomSheetViewController: UIViewController , UITextFieldDelegate{
    
    //MARK: - Properties
    
    var todoDataList : [GetTodoInfo]! = []
    
    var isDiaryExist = false //for 다이어리 작성했을 때 view 구성
    
    var diaryData: GetDiaryInfo?
    
    var todoDate : ConvertDate!
    
    var clampCell : IndexPath = [0,-1] //clamp cell default 값
    
    var homeNavigaiton : UINavigationController!
    
    var addButtonView: AddButtonViewController?
    
    let mainView = SummaryBottomSheetView()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        style()
        layout()
        initialize()
    }
    
    func style(){
        self.view.backgroundColor = UIColor(red: 134/255, green: 182/255, blue: 255/255, alpha: 1)
        setUpSheetVC()
    }
    
    func layout(){
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func initialize(){
        mainView.summaryTableView.delegate = self
        mainView.summaryTableView.dataSource = self
        mainView.summaryTableView.separatorStyle = .none
        
        mainView.summaryTableView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                              action: #selector(cellWillMoveToOriginalPosition)))
    }
    
    //MARK: - Action
    
    @objc
    func cellWillMoveToOriginalPosition(){
        guard let cell = mainView.summaryTableView.cellForRow(at: clampCell) as? TodoListTableViewCell else { return }
        cell.cellWillMoveOriginalPosition()
    }
    
    //아무런 todo 없는경우 배너 누르기-> 키보드 올리기
    @objc
    func tapBannerCell(){
        HomeViewController.dismissBottomSheet()
        
        let vc = TodoSettingViewController()
        vc.mainView.date.setTitle(todoDate.dateUsedTodo, for: .normal)
        vc.todoDate = todoDate
        
        self.homeNavigaiton.pushViewController(vc, animated: true)
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
        vc.mainView.todaysDate.text = vc.pickDate?.dateUsedDiary

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
extension SummaryBottomSheetViewController: MoveViewController, AddButtonClickProtocol{
    
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
        vc.mainView.date.setTitle(todoDate.dateUsedTodo, for: .normal)
        vc.todoDate = todoDate
        
        self.homeNavigaiton.pushViewController(vc, animated: true)
    }
    
    func willMoveAddDiary(){
        
        addButtonView!.dismiss(animated: false, completion: nil)
        
        let vc = DiaryViewController()

        vc.pickDate = HomeViewController.bottomSheetVC.todoDate
        vc.todoDataList = self.todoDataList
        vc.mainView.todaysDate.text = vc.pickDate?.dateUsedDiary

        if(isDiaryExist){
            vc.setUpDiaryData(diaryData!)
        }

        HomeViewController.dismissBottomSheet()
        self.homeNavigaiton.pushViewController(vc, animated: true)
    }
}

//MARK: - API
extension SummaryBottomSheetViewController{
    
    func checkSendCheckboxApiResultCode(indexPath: IndexPath, code: Int){
        switch code{
        case 1000:
            print("체크박스 API 성공")
            todoDataList[indexPath.row - 1].isChecked?.toggle()
            mainView.summaryTableView.reloadData()
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
            mainView.summaryTableView.reloadData()
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
            
            mainView.summaryTableView.moveRow(at: indexPath, to: IndexPath(row: newIndex + 1, section: 0))
            mainView.summaryTableView.reloadData()
            return
            
        default:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkTodoDeleteApiResultCode(_ code: Int, _ indexPath: IndexPath){
        switch code{
        case 1000:
            if(todoDataList.count == 1){
                todoDataList = []
                mainView.summaryTableView.reloadData()
            }else{
                todoDataList.remove(at: indexPath.row-1)
                mainView.summaryTableView.deleteRows(at: [indexPath], with: .fade)
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
            mainView.summaryTableView.reloadData()
            
            return
        case 2402:
            isDiaryExist = false
            mainView.summaryTableView.reloadData()
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
            mainView.summaryTableView.reloadData()
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
extension SummaryBottomSheetViewController: UITableViewDelegate, UITableViewDataSource{
    
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
extension SummaryBottomSheetViewController: SelectedTableViewCellDeliver{
    
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
            guard let cell = mainView.summaryTableView.cellForRow(at: clampCell)
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
        
        guard let clampCell = mainView.summaryTableView.cellForRow(at: clampCell) as? TodoListTableViewCell else { return }
        
        if(!clampCell.isClamp){
            HomeViewController.dismissBottomSheet()
            
            guard let tapCell = mainView.summaryTableView.cellForRow(at: indexPath) as? TodoListTableViewCell else { return }
            
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
