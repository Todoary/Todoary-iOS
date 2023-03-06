//
//  TodoCalendarBottomSheetViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/23.
//

import UIKit

class TodoCalendarBottomSheetViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var scrollDirection : scrollDiretion = .none
    
    let screenSize = UIScreen.main.bounds
    
    //받아올 날짜 데이터
    var todoYear : Int = -1
    var todoMonth : Int = -1
    var todoDay : Int = -1
    
    // 바텀 시트 높이
    let bottomHeight: CGFloat = 375
    
    //데이터 전달 delegate
    var delegate: CalendarComplete?
        
    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    //현재시간
    let now = Date()
    
    var cal = Calendar.current
    
    //년,월,일 데이터 형식
    let dateFormatterYear = DateFormatter()
    let dateFormatterMonth = DateFormatter()
    let dateFormatterDate = DateFormatter()
    
    var today : Int = 0
    
    var month_component : Int = 0
    var year_component : Int = 0
    
    var select_year : Int = 0
    var select_month : Int = 0
    var select_day : Int = 0
    
    var month : Int = 0
    var year : Int = 0
    
    var emptyDay : Int = 0
    var previousEmptyDay : Int = 0
    var nextEmptyDay : Int = 0
    
    var components = DateComponents()
    var components_previous = DateComponents()
    var components_next = DateComponents()
    
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
    
    // MARK: - UIComponents
    
    let dimmedBackView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
        
    // 바텀 시트 뷰
    let bottomSheetView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 27
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    let year_Month = UILabel().then{
        $0.text = "1999년 7월"
        $0.textColor = .black
        $0.font = UIFont.nbFont(ofSize: 18, weight: .extraBold)
        $0.tintColor = .clear
    }
    
    lazy var completeBtn = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: .semibold17)
        $0.addTarget(self, action: #selector(calendarCompleteBtnDidTap), for: .touchUpInside)
    }
    
    let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isPagingEnabled = true
    }
    
    let weekCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 19, bottom: 0, right: 19)
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        $0.collectionViewLayout = layout
    }
    
    
    let mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets.init(top: 3, left: 19, bottom: 0, right: 19)
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        $0.collectionViewLayout = layout
    }
    
    let previousCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets.init(top: 3, left: 19, bottom: 0, right: 19)
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        $0.collectionViewLayout = layout
    }
    
    let nextCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets.init(top: 3, left: 19, bottom: 0, right: 19)
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        $0.collectionViewLayout = layout
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        hierarchy()
        setupGestureRecognizer()
        
        self.initView()
        
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        
        weekCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(TodoWeekCell.self, forCellWithReuseIdentifier: "todoWeekCell")
        }
        
        mainCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(TodoCalendarCell.self, forCellWithReuseIdentifier: "todoCalendarCell")
        }
        
        previousCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(TodoCalendarCell.self, forCellWithReuseIdentifier: "todoCalendarCell")
        }
        
        nextCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(TodoCalendarCell.self, forCellWithReuseIdentifier: "todoCalendarCell")
        }
        self.view.layoutIfNeeded()
        
        scrollView.setContentOffset(CGPoint(x: screenSize.width, y: 0), animated: false)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }


    // MARK: - @Functions
    private func hierarchy() {
        view.addSubview(dimmedBackView)
        view.addSubview(bottomSheetView)
        bottomSheetView.addSubview(year_Month)
        bottomSheetView.addSubview(completeBtn)
        bottomSheetView.addSubview(weekCollectionView)
        bottomSheetView.addSubview(scrollView)
        scrollView.addSubview(mainCollectionView)
        scrollView.addSubview(previousCollectionView)
        scrollView.addSubview(nextCollectionView)
            
        dimmedBackView.alpha = 0.0
        layout()
    }

    // 레이아웃 세팅
    private func layout() {
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
        
        year_Month.snp.makeConstraints{ make in
            make.top.equalTo(bottomSheetView.snp.top).offset(25)
            make.leading.equalTo(bottomSheetView.snp.leading).offset(51)
        }
        
        weekCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(year_Month.snp.bottom).offset(0)
            make.leading.equalTo(bottomSheetView.snp.leading)
            make.trailing.equalTo(bottomSheetView.snp.trailing)
            make.width.equalTo(screenSize.width)
            make.height.equalTo(20)
        }
        
        scrollView.snp.makeConstraints{ make in
            make.top.equalTo(weekCollectionView.snp.bottom).offset(2)
            make.width.equalTo(screenSize.width * 3)
            make.leading.trailing.bottom.equalTo(bottomSheetView)
            make.height.equalTo(250)
        }
        
        previousCollectionView.snp.makeConstraints{ make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.equalTo(mainCollectionView.snp.leading)
            make.width.equalTo(screenSize.width)
            make.height.equalToSuperview()
        }
        
        mainCollectionView.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(previousCollectionView.snp.trailing)
            make.trailing.equalTo(nextCollectionView.snp.leading)
            make.width.equalTo(screenSize.width)
            make.height.equalToSuperview()
        }
        
        nextCollectionView.snp.makeConstraints{ make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(mainCollectionView.snp.trailing)
            make.width.equalTo(screenSize.width)
            make.height.equalToSuperview()
        }
        
        completeBtn.snp.makeConstraints{ make in
            make.top.equalTo(bottomSheetView.snp.top)
            make.trailing.equalTo(bottomSheetView.snp.trailing)
            make.width.equalTo(80)
            make.height.equalTo(60)
        }
        
        
        
    }
    
    //MARK: - Actions
    
    @objc func calendarCompleteBtnDidTap() {
        
        self.delegate?.calendarComplete(date: "\(select_year)년 \(select_month)월 \(select_day)일",date_api: "\(select_year)-\(String(format:"%02d",select_month))-\(String(format:"%02d", select_day))")
        
        hideBottomSheetAndGoBack()
    }
    
    //MARK: - Helpers
    
    // 바텀 시트 표출 애니메이션
    func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
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
    func setupGestureRecognizer() {
        // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedBackView.addGestureRecognizer(dimmedTap)
        dimmedBackView.isUserInteractionEnabled = true
        
        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    
    // UITapGestureRecognizer 연결 함수 부분
    @objc func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    // UISwipeGestureRecognizer 연결 함수 부분
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                hideBottomSheetAndGoBack()
            default:
                break
            }
        }
    }
}

protocol CalendarComplete {
    func calendarComplete(date: String, date_api: String)
}
