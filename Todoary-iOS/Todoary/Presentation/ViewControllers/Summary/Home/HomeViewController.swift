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
import Firebase
import Kingfisher

enum scrollDiretion {
    case left
    case none
    case right
}

class HomeViewController : UIViewController {
    
    
//MARK: - Properties
    
    var scrollDirection : scrollDiretion = .none
    
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
    var previousEmptyDay : Int = 0
    var nextEmptyDay : Int = 0
    
    var components = DateComponents()
    var components_previous = DateComponents()
    var components_next = DateComponents()
    var component_select = DateComponents()
    
    var select = -1
    
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var previousDays: [String] = []
    var nextDays: [String] = []
    
    var daysCountInMonth = 0
    var daysCountInMonth_previous = 0
    var daysCountInMonth_next = 0
    
    var weekdayAdding = 0
    var weekdayAdding_previous = 0
    var weekdayAdding_next = 0
    
    let inset = UIEdgeInsets(top: 1, left: 3, bottom: 0, right: 3)
    
    var calendarRecord = [Int](repeating: 0, count: 32)
    var diaryRecord = [Int](repeating: 0, count: 32)
    
    static let bottomSheetVC = SummaryBottomSheetViewController()
    
    let mainView = HomeView()
    
    var profileData: ProfileResultModel!
    
    let screenSize = UIScreen.main.bounds
    
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
        LoadingHUD.show()
        
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
        
        self.view.layoutIfNeeded()
        
        
        
        mainView.scrollView.delegate = self
        mainView.scrollView.showsHorizontalScrollIndicator = false
        
        mainView.weekCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(WeekCell.self, forCellWithReuseIdentifier: "weekCell")
        }
        
        mainView.collectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
        }
        
        mainView.previousCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
        }
        
        mainView.nextCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
        }
        
        mainView.scrollView.setContentOffset(CGPoint(x: screenSize.width, y: 0), animated: false)
        
        
        mainView.profileImage.addTarget(self, action: #selector(profileBtnDidTap), for: .touchUpInside)
        mainView.settingButton.addTarget(self, action: #selector(settingBtnDidTap), for: .touchUpInside)
        mainView.year_Month.addTarget(self, action: #selector(settingInit), for: .touchUpInside)
        
        self.initView()
    }
    
    func apiSetting() {
        self.calculation()
        let component = cal.date(from: components)
        
        requestGetTodoByYearMonth(yearMonth: "\(dateFormatterYear.string(from: component!))-\(dateFormatterMonth.string(from: component!))")
        requestGetDiaryByYearMonth(yearMonth: "\(dateFormatterYear.string(from: component!))-\(dateFormatterMonth.string(from: component!))")

        mainView.collectionView.reloadData()

        requestGetProfile()
        
        let fcmToken = FcmTokenRequestModel(fcm_token: UserDefaults.standard.string(forKey: "fcmToken"))
        requestModifyFcmToken(parameter: fcmToken)
        
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
        
//        Analytics.logEvent("AppIcon", parameters: [
//          "name": "comback_today" as NSObject,
//          "full_text": "오늘로 돌아가기 버튼 터치" as NSObject,
//        ])
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
                HomeViewController.bottomSheetVC.processResponseGetDiary(data: nil)
                break
            }
        }
    }
    
    func requestGetProfile(){
        ProfileService.shared.getProfile(){ [self] result in
            switch result{
            case .success(let data):
                if let data = data as? ProfileResultModel{
                    print("로그: [requestGetProfile] success in Home")
                    profileData = data
                    mainView.nickname.text = profileData.nickname
                    mainView.introduce.text = profileData.introduce
                    if UserDefaults.standard.bool(forKey: "defaultImg") != true {
                        if (profileData.profileImgUrl != nil){
                            let url = URL(string: profileData.profileImgUrl!)
                            mainView.profileImage.kf.setImage(with: url, for: .normal)
                        }
                    }else{
                        mainView.profileImage.setImage(UIImage(named: "profile"), for: .normal)
                    }
                    
                }
                break
            default:
                print("로그: [requestGetProfile] fail in Home")
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
                    print("로그: [requestGetTodoByYearMonth] success")
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
                print("로그: [requestGetTodoByYearMonth] fail")
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
                    print("로그: [requestGetDiaryByYearMonth] success")
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
                print("로그: [requestGetDiaryByYearMonth] fail")
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    func requestModifyFcmToken(parameter: FcmTokenRequestModel){
        FcmTokenService.shared.modifyFcmToken(request: parameter){ result in
            switch result{
            case .success:
                print("로그: [requestModifyFcmToken] success")
                break
            default:
                print("로그: [requestModifyFcmToken] fail")
                break
            }
        }
    }
    
//MARK: - Helpers
    
    
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
        
        for family in UIFont.familyNames {
        print("\(family)");
                    
        for names in UIFont.fontNames(forFamilyName: family) {
        print("== \(names)");
        }
        }
        
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
