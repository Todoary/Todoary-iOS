//
//  TodoCalendarBottomSheetViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/23.
//

import UIKit

class TodoCalendarBottomSheetViewController: UIViewController {
    
    
    // MARK: - Properties
    
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
    
    var month : Int = 0
    var year : Int = 0
    
    var emptyDay : Int = 0
    
    var components = DateComponents()
    
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0
    var weekdayAdding = 0
    
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
    
    let previousMonthBtn = UIButton().then{
        $0.setImage(UIImage(named: "home_previous"), for: .normal)
        $0.addTarget(self, action: #selector(prevBtnDidTap), for: .touchUpInside)
    }
    
    let nextMonthBtn = UIButton().then{
        $0.setImage(UIImage(named: "home_next"), for: .normal)
        $0.addTarget(self, action: #selector(nextBtnDidTap), for: .touchUpInside)
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = -2
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        $0.collectionViewLayout = layout
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setupGestureRecognizer()
        
        self.initView()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(TodoWeekCell.self, forCellWithReuseIdentifier: "todoWeekCell")
        self.collectionView.register(TodoCalendarCell.self, forCellWithReuseIdentifier: "todoCalendarCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }


    // MARK: - @Functions
    private func setUpView() {
        view.addSubview(dimmedBackView)
        view.addSubview(bottomSheetView)
        bottomSheetView.addSubview(collectionView)
        bottomSheetView.addSubview(year_Month)
        bottomSheetView.addSubview(previousMonthBtn)
        bottomSheetView.addSubview(nextMonthBtn)
        
            
        dimmedBackView.alpha = 0.0
        setUpConstraint()
    }

    // 레이아웃 세팅
    private func setUpConstraint() {
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
            make.top.equalTo(bottomSheetView.snp.top).offset(36)
            make.leading.equalTo(bottomSheetView.snp.leading).offset(51)
        }
        
        previousMonthBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(year_Month)
            make.trailing.equalTo(nextMonthBtn.snp.leading).offset(-13)
        }
        
        nextMonthBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(year_Month)
            make.trailing.equalTo(bottomSheetView.snp.trailing).offset(-34)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(year_Month.snp.bottom).offset(-2)
            make.centerX.equalTo(bottomSheetView)
            make.leading.equalTo(bottomSheetView.snp.leading).offset(34)
            make.trailing.equalTo(bottomSheetView.snp.trailing).offset(-34)
            make.bottom.equalTo(bottomSheetView.snp.bottom)
        }
        
    }
    
    //MARK: - Actions
    
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
