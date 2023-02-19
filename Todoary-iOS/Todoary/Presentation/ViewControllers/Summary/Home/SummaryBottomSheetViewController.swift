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
    var homeViewController: HomeViewController!
    
    var todoData = [TodoResultModel]()
    
    var isDiaryExist = false //for 다이어리 작성했을 때 view 구성
    var diaryData: DiaryResultModel?{
        didSet{
            isDiaryExist = diaryData == nil ? false : true
        }
    }
    
    var todoDate : ConvertDate!
    
    var clampCell : IndexPath = [0,-1]
    
    var homeNavigaiton : UINavigationController!
    
    
    let mainView = SummaryBottomSheetView()
    var addButtonView: AddButtonViewController? //TODO: ViewController 말고 View 사용으로 변경
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
    
        super.viewDidLoad()

        style()
        layout()
        initialize()
    }
    
    private func style(){
        self.view.backgroundColor = UIColor(red: 134/255, green: 182/255, blue: 255/255, alpha: 1)
        setUpSheetVC()
    }
    
    private func layout(){
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func initialize(){
        mainView.summaryTableView.delegate = self
        mainView.summaryTableView.dataSource = self
        mainView.summaryTableView.separatorStyle = .none
    }
    
    @objc func willMoveDiaryViewController(){

        let vc = DiaryViewController()

        vc.pickDate = HomeViewController.bottomSheetVC.todoDate
        vc.todoData = self.todoData
        vc.mainView.todaysDate.text = vc.pickDate?.dateUsedDiary

        if(isDiaryExist){
            vc.bindingData(diaryData!)
        }

        HomeViewController.dismissBottomSheet()
        self.homeNavigaiton.pushViewController(vc, animated: true)
    }
    
    //MARK: - Helper
 
    private func getPinnedCount() -> Int{
        todoData.filter({ $0.isPinned }).count
    }
    
    func dataArraySortByPin(){
        todoData.sort(by: {$0.createdTime < $1.createdTime})
        todoData.sort(by: {$0.targetTime ?? "25:00" < $1.targetTime ?? "25:00"})
        todoData.sort(by: {$0.isPinned! && !$1.isPinned!})
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
    
    func getTodoDataIndex(from cell: TodoInSummaryTableViewCell) -> Int!{
        guard let indexPath = mainView.summaryTableView.indexPath(for: cell) else { return nil }
        return indexPath.row - 1
    }
    
    func initializeTableView(){
        if let clampCell = mainView.summaryTableView.cellForRow(at: clampCell) as? TodoInSummaryTableViewCell{
            clampCell.removeHiddenViews()
            clampCell.isClamp = false
        }
    }
}

//MARK: - API
extension SummaryBottomSheetViewController: RequestSummaryCellDelegate{
    
    func requestPatchTodoCheckStatus(index: Int) {
        
        todoData[index].isChecked.toggle()
        mainView.summaryTableView.reloadData()
        let data = todoData[index]
        
        TodoService.shared.modifyTodoCheckStatus(id: data.todoId, isChecked: data.isChecked){ result in
            switch result{
            case .success(_):
                print("[requestPatchTodoCheckStatus] success")
                break
            default:
                print("[requestPatchTodoCheckStatus] fail")
                self.todoData[index].isChecked.toggle()
                DataBaseErrorAlert.show(in: self)
                break
            }
            
        }
    }
    
    private func requestDeleteDiary(){
        DiaryService.shared.deleteDiary(date: self.todoDate.dateSendServer){ result in
            switch result{
            case .success:
                self.processResponseDeleteDiary()
                break
            default:
                DataBaseErrorAlert.show(in: self.homeNavigaiton)
                break
            }
        }
    }
    
    private func processResponseDeleteDiary(){
        isDiaryExist = false
        mainView.summaryTableView.reloadData()
        showDeleteCompleteToastMessage(type: .Diary)
        
        homeViewController.requestGetDiaryByYearMonth(yearMonth: todoDate!.yearMonthSendServer)
    }
    
    private func requestPatchTodoPin(index: Int){

        todoData[index].isPinned.toggle()
        self.dataArraySortByPin()
        
        let parameter = todoData[index]
        
        guard let newIndex = todoData.firstIndex(of: parameter) else{ return }
        
        mainView.summaryTableView.moveRow(at: [0,index], to: IndexPath(row: newIndex + 1, section: 0))
        mainView.summaryTableView.reloadData()
        
        TodoService.shared.modifyTodoPinStatus(id: parameter.todoId,
                                               isPinned: parameter.isPinned){ result in
            switch result{
            case .success:
                print("[requestPatchTodoPin] success")
                break
            default:
                print("[requestPatchTodoPin] fail")
                self.todoData[index].isPinned.toggle()
                break
            }
        }
    }
    
    func requestPatchTodoAlarm(index: Int, request: TodoAlarmRequestModel){
        
        let id = todoData[index].todoId
        
        TodoService.shared.modifyTodoAlarm(id: id, request: request){ result in
            switch result{
            case .success:
                self.todoData[index].targetTime = request.targetTime
                self.todoData[index].isAlarmEnabled = true
                self.dataArraySortByPin()
                self.mainView.summaryTableView.reloadData()
                self.dismiss(animated: false)
                break
            default:
                break
            }
        }
    }
    
    func processResponseGetTodo(data: [TodoResultModel]){
        todoData = data
        dataArraySortByPin()
        initializeTableView()
        mainView.summaryTableView.reloadData()
    }
    
    func processResponseGetDiary(data: DiaryResultModel?){
        diaryData = data
        mainView.summaryTableView.reloadData()
    }
    
    func requestDeleteTodo(cell: TodoInSummaryTableViewCell){
        
        guard let indexPath = mainView.summaryTableView.indexPath(for: cell) else { return }
        let dataIndex = indexPath.row - 1
        let todo = todoData[dataIndex]
        
        TodoService.shared.deleteTodo(id: todo.todoId){ result in
            switch result{
            case .success:
                print("LOG: SUCCESS requestDeleteTodo")
                if(self.todoData.count == 1){
                    self.todoData = []
                    self.mainView.summaryTableView.reloadData()
                }else{
                    self.todoData.remove(at: dataIndex)
                    self.mainView.summaryTableView.deleteRows(at: [indexPath], with: .fade)
                }
                self.showDeleteCompleteToastMessage(type: .Todo)
                self.homeViewController.requestGetTodoByYearMonth(yearMonth: self.todoDate!.yearMonthSendServer)
                break
            default:
                print("LOG: FAIL requestDeleteTodo")
                let alert = DataBaseErrorAlert()
                self.present(alert, animated: true, completion: nil)
                break
            }
        }
    }
    
    
}

//TODO: DELETE
protocol MoveViewController{
    func moveToViewController()
}

//MARK: - AddButtonDelegate
extension SummaryBottomSheetViewController: MoveViewController, AddButtonClickProtocol{
    
    func moveToViewController() {

        addButtonView = AddButtonViewController().then{
            $0.delegate = self
            $0.modalPresentationStyle = .overFullScreen
        }
        
        guard let addButtonView = addButtonView else { return }
        
        if(self.sheetPresentationController?.selectedDetentIdentifier == nil
           || self.sheetPresentationController?.selectedDetentIdentifier?.rawValue == "Test1"){
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
        vc.todoData = self.todoData
        vc.mainView.todaysDate.text = vc.pickDate?.dateUsedDiary

        if(diaryData != nil){
            vc.bindingData(diaryData!)
        }

        HomeViewController.dismissBottomSheet()
        self.homeNavigaiton.pushViewController(vc, animated: true)
    }
}

//MARK: - TableView
extension SummaryBottomSheetViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData.count != 0 ? todoData.count + 3 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowCount = tableView.numberOfRows(inSection: 0)
        
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TodoTitleInSummaryTableViewCell.self).then{
                $0.delegate = self
            }
            return cell
        case rowCount - 2:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DiaryTitleInSummaryTableViewCell.self).then{
                $0.delegate = self
                $0.isDiaryExist = isDiaryExist ? true : false
            }
            return cell
        case rowCount - 1:
            //선택한 날짜에 다이어리 존재 여부에 따른 table cell 구성 differ
            if(isDiaryExist){
                let cell =  tableView.dequeueReusableCell(for: indexPath, cellType: DiaryInSummaryTableViewCell.self)
                if let diaryData = self.diaryData {
                    cell.bindingDiaryData(diaryData)
                }
                return cell
            }else{
                return tableView.dequeueReusableCell(for: indexPath, cellType: DiaryBannerInSummaryTableViewCell.self)
            }

        default:
            if(todoData.isEmpty){
                return tableView.dequeueReusableCell(for: indexPath, cellType: TodoBannerInSummaryTableViewCell.self)
            }
        
            let todo = todoData[indexPath.row-1]
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TodoInSummaryTableViewCell.self).then{
                $0.requestDelegate = self
                $0.delegate = self
                $0.bindingData(todo)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        isClampCellExist { cell in
            cell.willMoveOriginalPosition()
            return
        }

        let rowCount = tableView.numberOfRows(inSection: 0)
        if(indexPath.row == 1 && todoData.isEmpty){
            willMoveToAddTodo()
        }else if(indexPath.row == rowCount - 1){
            willMoveDiaryViewController()
        }
    }
    
    private func isClampCellExist(closure: (TodoInSummaryTableViewCell) -> Void){
        if let cell = mainView.summaryTableView.cellForRow(at: clampCell) as? TodoInSummaryTableViewCell{
            if(cell.isClamp){
                closure(cell)
            }
        }
    }
    
    @objc private func willMoveToAddTodo(){
        HomeViewController.dismissBottomSheet()
        
        let vc = TodoSettingViewController()
        vc.mainView.date.setTitle(todoDate.dateUsedTodo, for: .normal)
        vc.todoDate = todoDate
        
        self.homeNavigaiton.pushViewController(vc, animated: true)
    }
}



//MARK: - TableViewCell Delegate
extension SummaryBottomSheetViewController: SelectedTableViewCellDeliver{
    
    func cellWillPin(_ indexPath: IndexPath){
        
        let pinnedCount = getPinnedCount()
        let willChangeData = todoData[indexPath.row-1]
        let currentPin = willChangeData.isPinned!
    
        if(!currentPin && pinnedCount >= 2){ //pin 상태가 아니지만, 핀 고정 개수 초과
            _ = ConfirmAlertViewController(title: "고정은 2개까지만 가능합니다.").show(in: self)
            return
        }
        requestPatchTodoPin(index: indexPath.row - 1)
    }
    
    func cellWillClamp(_ indexPath: IndexPath){
        
        //1. 기존 고정 cell 존재 여부 점검 (row 값 -1인지 아닌지)
        if(clampCell == indexPath){
            return
        }else if(clampCell.row != -1){
        //2. -1 아닐 경우 -> 이미 고정되어 있는 cell 존재 -> 고정 풀기
            guard let cell = mainView.summaryTableView.cellForRow(at: clampCell)
                    as? TodoInSummaryTableViewCell else{ return }
            cell.willMoveOriginalPosition()
        }
        //row 값 -1일 때와, row 값 -1 아닐 때 공통 코드(즉, 자기 자신 아닐 때만 제외)
        clampCell = indexPath
    }
    
    func cellDidTapped(_ indexPath: IndexPath) {
        
        if let clampCell = mainView.summaryTableView.cellForRow(at: clampCell) as? TodoInSummaryTableViewCell {
            if(clampCell.isClamp){
                clampCell.willMoveOriginalPosition()
                return
            }
        }
        
        HomeViewController.dismissBottomSheet()
        
        guard let tapCell = mainView.summaryTableView.cellForRow(at: indexPath) as? TodoInSummaryTableViewCell else { return }

        let vc = TodoSettingViewController()
        vc.todoSettingData = tapCell.todo
        TodoSettingViewController.selectCategory = tapCell.todo.categoryId
        
        self.homeNavigaiton.pushViewController(vc, animated: true)
    }
    
    func cellWillAlarmEnabled(_ indexPath: IndexPath) {
        
        let alert = AlarmAlertViewController().then{
            let index = indexPath.row - 1
            $0.todoData = todoData[index]
            $0.completion = { request in
                self.requestPatchTodoAlarm(index: index, request: request)
            }
        }
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)
    }
}

//MARK: - BottomSheet Swipe Delegate
extension SummaryBottomSheetViewController: UISheetPresentationControllerDelegate{
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if let clampCell = mainView.summaryTableView.cellForRow(at: clampCell) as? TodoInSummaryTableViewCell {
            if(clampCell.isClamp){
                clampCell.willMoveOriginalPosition()
                return
            }
        }
    }
}

extension SummaryBottomSheetViewController: SummaryCellDelegate{
    
    func willShowAddTodoOrDiaryButton() {
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
    
    func willMoveCategoryViewController() {
        HomeViewController.dismissBottomSheet()
        homeNavigaiton.pushViewController(CategoryViewController(), animated: true)
    }
    
    func willShowDiaryDeleteAlert() {
        _ = CancelAlertViewController(title: "다이어리를 삭제하시겠습니까?").show(in: self).then{
            $0.alertHandler = {
                self.requestDeleteDiary()
            }
        }
    }
}
