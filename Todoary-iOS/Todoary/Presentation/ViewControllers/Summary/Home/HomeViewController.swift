//
//  HomeViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit
import SnapKit
import Then

class HomeViewController : UIViewController {
    
    
    //MARK: - Properties
    
    static var check : Int!
    
    var nickname = ""
    var introduce = ""
    let now = Date()
    var cal = Calendar.current
    let dateFormatterYear = DateFormatter()
    let dateFormatterMonth = DateFormatter()
    let dateFormatterDate = DateFormatter()
    var today : Int = 0
    var month_component : Int = 0
    var year_component : Int = 0
    var month : Int = 0
    var year : Int = 0
    var emptyDay : Int = 0
    var components = DateComponents()
    var component_select = DateComponents()
    var select = -1
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0
    var weekdayAdding = 0
    let inset = UIEdgeInsets(top: 1, left: 3, bottom: 0, right: 3)
    
    var calendarRecord = [Int](repeating: 0, count: 32)
    var diaryRecord = [Int](repeating: 0, count: 32)
    
    static let bottomSheetVC = SummaryBottomSheetViewController()
    
    let mainView = HomeView()
    
    var profileData: ProfileResultModel!
    
//MARK: - Lifecycles

    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        style()
        layout()
        initialize()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        apiSetting()
        showBottomSheet()
        
    }
    
    //MARK: - BaseProtocol
    
    func style() {
    }
    
    func layout() {
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func initialize() {
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(WeekCell.self, forCellWithReuseIdentifier: "weekCell")
        mainView.collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
        
        mainView.profileImage.addTarget(self, action: #selector(profileBtnDidTap), for: .touchUpInside)
        mainView.settingButton.addTarget(self, action: #selector(settingBtnDidTap), for: .touchUpInside)
        mainView.year_Month.addTarget(self, action: #selector(settingInit), for: .touchUpInside)
        mainView.previousMonthButton.addTarget(self, action: #selector(prevBtnDidTap), for: .touchUpInside)
        mainView.nextMonthButton.addTarget(self, action: #selector(nextBtnDidTap), for: .touchUpInside)
        
        self.initView()
    }
    
    func apiSetting() {
        self.calculation()
        let component = cal.date(from: components)
        
        requestGetTodoByYearMonth(yearMonth: "\(dateFormatterYear.string(from: component!))-\(dateFormatterMonth.string(from: component!))")
        requestGetDiaryByYearMonth(yearMonth: "\(dateFormatterYear.string(from: component!))-\(dateFormatterMonth.string(from: component!))")

        mainView.collectionView.reloadData()

        requestGetProfile()

        let fcmToken = FcmTokenInput(fcm_token: UserDefaults.standard.string(forKey: "fcmToken"))

        FcmTokendataManager().fcmTokendataManager(self, fcmToken)
        
    }
    
    //MARK: - Actions
    
    @objc func settingBtnDidTap(_ sender: UIButton){
        HomeViewController.dismissBottomSheet()
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    @objc func profileBtnDidTap() {
        HomeViewController.dismissBottomSheet()
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    
    // 년,월 누르기 -> 오늘로 돌아가기
    @objc func settingInit(){
        self.initView()
        
        let convertDate = ConvertDate(year: self.year,
                                      month: self.month,
                                      date: String(self.today)).dateSendServer
        
        requestGetTodoByDate(convertDate)
        requestGetDiary(convertDate)
    }
    
    //MARK: - API
    
    func requestGetTodoByDate(_ date: String){
        TodoService.shared.getTodoByDate(date: date){ result in
            switch result{
            case .success(let data):
                guard let data = data as? [TodoResultModel] else { return }
                HomeViewController.bottomSheetVC.processResponseGetTodo(data: data)
                break
            case .requestErr:
                break
            default:
                break
            }
        }
    }
    
    func requestGetDiary(_ date: String){
        DiaryService.shared.getDiary(date: date){ result in
            switch result{
            case .success(let data):
                let data = data as? DiaryResultModel
                HomeViewController.bottomSheetVC.processResponseGetDiary(data: data)
                break
            default:
                break
            }
        }
    }
    
    func requestGetProfile(){
        ProfileService.shared.getProfile(viewcontroller: self){ [self] result in
            switch result{
            case .success(let data):
                if let data = data as? ProfileResultModel{
                    print("[requestGetProfile] success in Home")
                    profileData = data
                    mainView.nickname.text = profileData.nickname
                    mainView.introduce.text = profileData.introduce
                    if (profileData.profileImgUrl != nil){
                        let url = URL(string: profileData.profileImgUrl!)
                        mainView.profileImage.load(url: url!)
                    }
                }
                break
            default:
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }

    func requestGetTodoByYearMonth(yearMonth: String){
        TodoService.shared.getTodoByYearMonth(yearMonth: yearMonth){ [self] result in
            switch result{
            case .success(let data):
                if let calendarData = data as? [Int]{
                    print("[requestGetTodoByYearMonth] success")
                    calendarRecord = [Int](repeating: 0, count: 32)
                    
                    if ((calendarData.isEmpty) != true){
                        for i in 0...calendarData.count-1{
                            calendarRecord[calendarData[i]] = calendarData[i]
                        }
                    }
                    mainView.collectionView.reloadData()
                }
                break
            default:
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    func requestGetDiaryByYearMonth(yearMonth: String){
        DiaryService.shared.getDiaryByYearMonth(yearMonth: yearMonth){ [self] result in
            switch result{
            case .success(let data):
                if let diaryData = data as? [Int]{
                    print("[requestGetDiaryByYearMonth] success")
                    diaryRecord = [Int](repeating: 0, count: 32)
                    
                    if ((diaryData.isEmpty) != true){
                        for i in 0...diaryData.count-1{
                            diaryRecord[diaryData[i]] = diaryData[i]
                        }
                    }
                    mainView.collectionView.reloadData()
                }
                break
            default:
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    //MARK: - Helpers
    func refreshView(){
        mainView.nickname.text = profileData.nickname
        mainView.introduce.text = profileData.introduce
        if (profileData.profileImgUrl != nil){
            let url = URL(string: profileData.profileImgUrl!)
            mainView.profileImage.load(url: url!)
        }
    }
    
    static func dismissBottomSheet(){
        HomeViewController.bottomSheetVC.dismiss(animated: true, completion: nil)
    }
    
    func showBottomSheet(){
        HomeViewController.bottomSheetVC.homeNavigaiton = self.navigationController
        HomeViewController.bottomSheetVC.homeViewController = self
        
        HomeViewController.bottomSheetVC.loadViewIfNeeded()
        
        let pickDate = HomeViewController.bottomSheetVC.todoDate.dateSendServer
        
        requestGetTodoByDate(pickDate)
        requestGetDiary(pickDate)
        
        present(HomeViewController.bottomSheetVC, animated: true, completion: nil)
    }
}


class paddingLabel: UILabel {
    var padding = UIEdgeInsets(top: 1.5, left: 5, bottom: 0, right: 5)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
            var contentSize = super.intrinsicContentSize
            contentSize.height += padding.top + padding.bottom
            contentSize.width += padding.left + padding.right
            
            return contentSize
        }
}

extension UIButton {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.setImage(image, for: .normal)
                    }
                }
            }
        }
    }
}
