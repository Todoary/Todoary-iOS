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

class HomeViewController : UIViewController, BaseViewControllerProtocol {
    
    
    //MARK: - Properties
    
    
    //MARK: - Properties
    
    static var check : Int!
    
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
    
<<<<<<< Updated upstream:Todoary-iOS/Todoary/Presentation/ViewControllers/Summary/HomeViewController.swift
    static let bottomSheetVC = SummaryBottomViewController()
=======
    static let bottomSheetVC = SummaryBottomSheetViewController()
>>>>>>> Stashed changes:Todoary-iOS/Todoary/Presentation/ViewControllers/Summary/Home/HomeViewController.swift
    
    let mainView = HomeView()
    
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
        
        self.calculation()
        let component = cal.date(from: components)

        GetCalendataManager().getCalendataManager(self, yearMonth: "\(dateFormatterYear.string(from: component!))-\(dateFormatterMonth.string(from: component!))")

        GetDiaryDataManager().getDiaryDataManager(self, yearMonth: "\(dateFormatterYear.string(from: component!))-\(dateFormatterMonth.string(from: component!))")

        mainView.collectionView.reloadData()

        GetProfileDataManager().getProfileDataManger(self)

        let fcmToken = FcmTokenInput(fcm_token: UserDefaults.standard.string(forKey: "fcmToken"))

        FcmTokendataManager().fcmTokendataManager(self, fcmToken)

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
        
        let convertDate = ConvertDate(year: self.year, month: self.month, date: String(self.today))
        
        GetTodoDataManager().gets(convertDate.dateSendServer)
        DiaryDataManager().gets(convertDate.dateSendServer)
    }
    
    //MARK: - API
    
    func successAPI_home(_ result : GetProfileResult) {
        mainView.nickname.text = result.nickname
        mainView.introduce.text = result.introduce
        if (result.profileImgUrl != nil){
            let url = URL(string: result.profileImgUrl!)
            mainView.profileImage.load(url: url!)
        }
    }
    
    func failureAPI_home() {
        if ((mainView.nickname.text?.isEmpty) == true) {
            self.initView()
            print("하이1")
        }else {
            print("하이")
        }
        viewWillAppear(true)
    }
    
    func successAPI_calendar(_ result : [Int]) {
        
        calendarRecord = [Int](repeating: 0, count: 32)
        
        if !result.isEmpty{
            for i in 0...result.count-1{
                calendarRecord[result[i]] = result[i]
            }
        }
        mainView.collectionView.reloadData()
    }
    
    func successAPI_diary(_ result : [Int]) {
        
        diaryRecord = [Int](repeating: 0, count: 32)
        
        if !result.isEmpty{
            for i in 0...result.count-1{
                diaryRecord[result[i]] = result[i]
            }
        }
        mainView.collectionView.reloadData()
    }
    
    //MARK: - Helpers
    
    static func dismissBottomSheet(){
        HomeViewController.bottomSheetVC.dismiss(animated: true, completion: nil)
    }
    
    func showBottomSheet(){
        HomeViewController.bottomSheetVC.homeNavigaiton = self.navigationController
        
        HomeViewController.bottomSheetVC.loadViewIfNeeded()
        
        let pickDate = HomeViewController.bottomSheetVC.todoDate.dateSendServer
        
        GetTodoDataManager().gets(pickDate)
        DiaryDataManager().gets(pickDate)
        GetCategoryDataManager().getCategoryDataManager(HomeViewController.bottomSheetVC)
        
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
