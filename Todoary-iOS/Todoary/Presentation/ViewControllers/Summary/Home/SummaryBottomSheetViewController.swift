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
    
    var todoData = [TodoResultModel](){
        didSet{
            self.mainView.summaryTableView.reloadData()
        }
    }
    
    var isDiaryExist = false //for 다이어리 작성했을 때 view 구성
    var diaryData: GetDiaryInfo?
    
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
        
        mainView.summaryTableView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                              action: #selector(cellWillMoveToOriginalPosition)))
    }
    
    //MARK: - Action
    
    @objc func cellWillMoveToOriginalPosition(){
        guard let cell = mainView.summaryTableView.cellForRow(at: clampCell) as? TodoInSummaryTableViewCell else { return }
        cell.cellWillMoveOriginalPosition()
    }
    
    //TODO: - will delete?
    //아무런 todo 없는경우 배너 누르기-> 키보드 올리기
    @objc func tapBannerCell(){
        HomeViewController.dismissBottomSheet()
        
        let vc = TodoSettingViewController()
        vc.mainView.date.setTitle(todoDate.dateUsedTodo, for: .normal)
        vc.todoDate = todoDate
        
        self.homeNavigaiton.pushViewController(vc, animated: true)
    }
    
    @objc func deleteDiaryAlertWillShow(){
        
        let alert = CancelAlertViewController(title: "다이어리를 삭제하시겠습니까?").show(in: self)
        alert.alertHandler = {
            self.requestDeleteDiary()
        }
    }
    
    @objc func willMoveDiaryViewController(){

        let vc = DiaryViewController()

        vc.pickDate = HomeViewController.bottomSheetVC.todoDate
        vc.todoDataList = self.todoData
        vc.mainView.todaysDate.text = vc.pickDate?.dateUsedDiary

        if(isDiaryExist){
            vc.setUpDiaryData(diaryData!)
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
}

//MARK: - API
extension SummaryBottomSheetViewController: RequestSummaryCellDelegate{
    
    func requestPatchTodoCheckStatus(cell: TodoInSummaryTableViewCell) {
        
        guard let indexPath = mainView.summaryTableView.indexPath(for: cell) else { return }
        let index = indexPath.row - 1
        
        todoData[index].isChecked.toggle()
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
    func processResponseDeleteDiary(){
        isDiaryExist = false
        mainView.summaryTableView.reloadData()
        showDeleteCompleteToastMessage(type: .Diary)
        
        //TODO: API 대체
        GetDiaryDataManager().getDiaryDataManager(self, yearMonth: todoDate!.yearMonthSendServer)
    }
}

//MARK: - AddButtonDelegate
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
        vc.todoDataList = self.todoData
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
    
    func checkGetTodoApiResultCode(_ result: GeneralResponse<[TodoResultModel]>){

        switch result.code{
        case 1000:
            todoData = result.result ?? []
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
            var willChangeData = todoData[indexPath.row-1]
            
            willChangeData.isPinned!.toggle()
            todoData[indexPath.row-1].isPinned = willChangeData.isPinned
            
            dataArraySortByPin()
        
            guard let newIndex = todoData.firstIndex(of: willChangeData) else{ return }
            
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
            if(todoData.count == 1){
                todoData = []
                mainView.summaryTableView.reloadData()
            }else{
                todoData.remove(at: indexPath.row-1)
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTitleInSummaryTableViewCell.cellIdentifier, for: indexPath)
                    as? TodoTitleInSummaryTableViewCell else{ fatalError() }
            cell.navigaiton = homeNavigaiton
            cell.delegate = self
            return cell
        case rowCount - 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryInSummaryTableViewCell.cellIdentifier, for: indexPath) as? DiaryInSummaryTableViewCell else{ fatalError() }
            if(isDiaryExist){
                cell.deleteBtn.isHidden = false
                cell.deleteBtn.addTarget(self, action: #selector(deleteDiaryAlertWillShow), for: .touchUpInside)
            }else{
                cell.deleteBtn.isHidden = true
            }
            return cell
        case rowCount - 1:
            
            //선택한 날짜에 다이어리 존재 여부에 따른 table cell 구성 differ
            if(isDiaryExist){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTitleInSummaryTableViewCell.cellIdentifier, for: indexPath)
                        as? DiaryTitleInSummaryTableViewCell else{ fatalError()}
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(willMoveDiaryViewController))
                cell.addGestureRecognizer(tapGesture)
                
                if let diaryData = self.diaryData {
                    cell.setUpDataBinding(diaryData)
                }
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: DiaryBannerInSummaryTableViewCell.cellIdentifier, for: indexPath)
                return cell
            }

        default:
            if(todoData.count != 0){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoInSummaryTableViewCell.cellIdentifier, for: indexPath)
                        as? TodoInSummaryTableViewCell else{ fatalError() }
                
                cell.navigation = homeNavigaiton
                cell.requestDelegate = self
                cell.delegate = self
                cell.cellData = todoData[indexPath.row-1]
                cell.cellWillSettingWithData()
                
                return cell
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoBannerInSummaryTableViewCell.cellIdentifier, for: indexPath)
                        as? TodoBannerInSummaryTableViewCell else{ fatalError() }
                
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
        
        let willChangeData = todoData[indexPath.row-1]
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
                    as? TodoInSummaryTableViewCell else{ return }
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
        
        guard let clampCell = mainView.summaryTableView.cellForRow(at: clampCell) as? TodoInSummaryTableViewCell else { return }
        
        if(!clampCell.isClamp){
            HomeViewController.dismissBottomSheet()
            
            guard let tapCell = mainView.summaryTableView.cellForRow(at: indexPath) as? TodoInSummaryTableViewCell else { return }
            
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
        alert.todoData = todoData[indexPath.row - 1]
        alert.modalPresentationStyle = .overFullScreen
        
        self.present(alert, animated: false, completion: nil)
    }
}
