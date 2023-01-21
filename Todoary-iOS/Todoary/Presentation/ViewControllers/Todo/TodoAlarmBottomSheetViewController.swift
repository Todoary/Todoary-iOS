//
//  TodoAlarmBottomSheetViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/26.
//

class TodoAlarmBottomSheetViewController: UIViewController {
    
    
    // MARK: - Properties
    
    //protocol
    var delegate: AlarmComplete?
    
    //시간
    let formatter = DateFormatter()
    
    var timeStr = ""
    var time_api : String!
    var todoSettingVC : UIViewController?
    
    // 바텀 시트 높이
    let bottomHeight: CGFloat = 273
        
    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
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
    
    lazy var completeBtn = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 16, weight: .semibold )
        $0.addLetterSpacing(spacing: 0.28)
        $0.addTarget(self, action: #selector(timecompleteBtnDidTap), for: .touchUpInside)
    }
    
    let timePicker = UIDatePicker().then{
        $0.backgroundColor = .clear
        $0.datePickerMode = .time
        $0.preferredDatePickerStyle = .wheels
        $0.addTarget(self, action: #selector(timePickerValueDidChange(_:)), for: .valueChanged)
        $0.locale = Locale(identifier: "en_US")
    }
    

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hierarchy()
        setupGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }


    // MARK: - @Functions
    private func hierarchy() {
        view.addSubview(dimmedBackView)
        view.addSubview(bottomSheetView)
        
        bottomSheetView.addSubview(timePicker)
        bottomSheetView.addSubview(completeBtn)
            
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
        
        timePicker.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalTo(bottomSheetView)
        }
        
        completeBtn.snp.makeConstraints{ make in
            make.top.equalTo(bottomSheetView.snp.top)
            make.trailing.equalTo(bottomSheetView.snp.trailing)
            make.width.equalTo(80)
            make.height.equalTo(60)
        }
        
    }
    
    //MARK: - Actions
    @objc func timePickerValueDidChange(_ datePicker: UIDatePicker) {
        formatter.dateFormat = "a hh:mm"
        formatter.locale = Locale(identifier: "en_US")
        timeStr = formatter.string(from: timePicker.date)
    }
    
    @objc func timecompleteBtnDidTap() {
        formatter.dateFormat = "a hh:mm"
        formatter.locale = Locale(identifier: "en_US")
        timeStr = formatter.string(from: timePicker.date)
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        timeFormat.locale = Locale(identifier: "fr_FR")
        print(timeFormat.string(from: timePicker.date))
        time_api = timeFormat.string(from: timePicker.date)
        self.delegate?.alarmComplete(time: timeStr, time_api: time_api)
        hideBottomSheetAndGoBack()
    }
    
    //MARK: - Helpers
    
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack() {
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
    private func setupGestureRecognizer() {
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
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
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

protocol AlarmComplete {
    func alarmComplete(time: String, time_api: String)
}
