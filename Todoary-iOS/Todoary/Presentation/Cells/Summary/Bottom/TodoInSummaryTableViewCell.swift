//
//  TodoInSummaryTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/16.
//

import UIKit
import SnapKit

enum CurrentHidden{
    case none
    case left
    case right
}

protocol RequestSummaryCellDelegate{
    func requestPatchTodoCheckStatus(index: Int)
    func requestDeleteTodo(cell: TodoInSummaryTableViewCell)
}

protocol SelectedTableViewCellDeliver: AnyObject{
    func cellDidTapped(_ indexPath: IndexPath)
    func cellWillAlarmEnabled(_ indexPath: IndexPath)
    func cellWillPin(_ indexPath: IndexPath)
    func cellWillClamp(_ indexPath: IndexPath)
}

class TodoInSummaryTableViewCell: BaseTableViewCell {
    
    //MARK: - Properties
    var todo: TodoResultModel!
    var requestDelegate: RequestSummaryCellDelegate!
    weak var delegate : SelectedTableViewCellDeliver?
    
    //MARK: - Properties(for swipe)
    
    private let leftWidth : CGFloat = 105
    private let rightWidth : CGFloat = 58
    
    //hiddenView addSubView 되었는지 아닌지 확인 용도
    lazy var isViewAdd : CurrentHidden = .none
    lazy var originalCenter = CGPoint()
    lazy var isClamp = false
    
    //MARK: - UI
    
    private let backgroundShadowView = ShadowView(cornerRadius: 20)
    private lazy var checkBox = UIButton().then{
        $0.setImage(Image.todoCheckEmpty, for: .normal)
        $0.setImage(Image.todoCheck, for: .selected)
    }
    
    private let titleLabel = UILabel().then{
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.setTypoStyleWithSingleLine(typoStyle: .bold15_18)
    }
    
    private let categoryButton = CategoryTag.generateForMainTodo()
    
    private lazy var pinImage = UIImageView().then{
        $0.image = Image.pushPin
    }
    
    private lazy var alarmImage = UIImageView().then{
        $0.image = Image.notifications
    }
    
    private let timeLabel = UILabel().then{
        $0.textColor = .timeColor
        $0.setTypoStyleWithSingleLine(typoStyle: .medium13)
    }
    
    private lazy var hiddenView = ShadowView(cornerRadius: 20)
    private lazy var hiddenLeftView = HiddenLeftButtonView()
    private lazy var hiddenRightView = HiddenRightButtonView()
    
    //MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        pinImage.removeFromSuperview()
        alarmImage.removeFromSuperview()
        timeLabel.removeFromSuperview()
        titleLabel.text = ""
        checkBox.isSelected = false
        
        titleLabel.snp.removeConstraints()
        categoryButton.snp.removeConstraints()
        removeHiddenViews()
        isClamp = false
    }
    
    override func style() {
        super.style()
        baseView.backgroundColor = .transparent
    }
    
    override func hierarchy() {
        
        super.hierarchy()
        
        baseView.addSubview(backgroundShadowView)
        
        self.backgroundShadowView.addSubview(checkBox)
        self.backgroundShadowView.addSubview(titleLabel)
        self.backgroundShadowView.addSubview(categoryButton)
    }
    
    override func layout() {
        
        super.layout()
        
        baseView.snp.makeConstraints{ make in
            make.height.equalTo(75)
        }
        backgroundShadowView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        checkBox.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().offset(19)
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
        }
    }
    
    private func initialize(){
        initializeGesture()
        initializeButtonInteraction()
    }
    
    private func initializeButtonInteraction(){
        
        checkBox.addTarget(self, action: #selector(checkBoxDidClicked), for: .touchUpInside)
        
        hiddenLeftView.pinButton.addTarget(self, action: #selector(pinButtonDidClicked), for: .touchUpInside)
        hiddenLeftView.alarmBtn.addTarget(self, action: #selector(alarmBtnDidClicked(_:)), for: .touchUpInside)
        
        hiddenRightView.deleteButton.addTarget(self, action: #selector(deleteButtonDidClicked), for: .touchUpInside)
    }
    
    private func initializeGesture(){
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))).then{
            $0.delegate = self
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellDidTapped)).then{
            $0.delegate = self
        }
        backgroundShadowView.addGestureRecognizer(swipeGesture)
        backgroundShadowView.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Method
    
    func bindingData(_ todo: TodoResultModel){
        
        self.todo = todo
        
        titleLabel.text = todo.title
        timeLabel.text = todo.convertTime
        checkBox.isSelected = todo.isChecked
        
        categoryButton.bindingData(title: todo.categoryTitle, color: todo.color)
        
        hiddenLeftView.pinButton.isSelected = todo.isPinned! ? true : false
        hiddenLeftView.alarmBtn.isSelected = todo.isAlarmEnabled ? true : false
        
        setUpViewByCase()
        
    }
    
    @objc func cellDidTapped(){
        guard let indexPath = getCellIndexPath() else { fatalError("indexPath casting error") }
        delegate?.cellDidTapped(indexPath)
    }
    
}

//MARK: - Swipe Method
extension TodoInSummaryTableViewCell{
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer){
        
        let translation = recognizer.translation(in: self)
        let superView = self.superview?.superview
        
        if(recognizer.state == .began){
            originalCenter = center
            hiddenSettingViewShow()
        }
        if (recognizer.state == .changed){
            
            center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y)
            
            //기존: 왼: 1.5, 오: 1.2 -> new: 왼: 1.2, 오: 1.5
            if(frame.origin.x > 0){ //왼쪽 view
                isClamp = frame.origin.x > leftWidth * 1.2 && isViewAdd != .right
            }else{  //오른쪽 view
                isClamp = frame.origin.x < -rightWidth * 1.5 && isViewAdd != .left
            }
        }
        if recognizer.state == .ended {
            if !isClamp {
                willMoveOriginalPosition()
            }else{
                guard let indexPath = getCellIndexPath() else { fatalError("indexPath casting error") }
                
                delegate?.cellWillClamp(indexPath)
                
                let clampFrame : CGRect!
                if(frame.origin.x < 0){
                    isViewAdd = .right
                    clampFrame = CGRect(x: -rightWidth,
                                        y: frame.origin.y,
                                        width: bounds.size.width,
                                        height: bounds.size.height)
                    superView?.bringSubviewToFront(hiddenRightView)
                    //                    superView?.bringSubviewToFront(HomeViewController.bottomSheetVC.addButton)
                    UIView.animate(withDuration: 0.4, animations: {self.frame = clampFrame})
                }else{
                    isViewAdd = .left
                    clampFrame = CGRect(x: leftWidth,
                                        y: frame.origin.y,
                                        width: bounds.size.width,
                                        height: bounds.size.height)
                    superView?.bringSubviewToFront(hiddenLeftView)
                    UIView.animate(withDuration: 0.32, animations: {self.frame = clampFrame})
                }
                
            }
        }
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translation(in: superview)
            if abs(translation.x) > abs(translation.y) {
                return true
            }
            return false
        }
        
        if gestureRecognizer is UITapGestureRecognizer{
            return true
        }
        return false
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.backgroundShadowView) == true {
            return true
        }
        return false
    }
    
    func moveBackHiddenView(){
        
        let superView = self.superview?.superview
        
        superView?.sendSubviewToBack(self.hiddenLeftView)
        superView?.sendSubviewToBack(self.hiddenRightView)
        superView?.sendSubviewToBack(self.hiddenView)
    }
    
    func removeHiddenViews(){
        
        hiddenView.removeFromSuperview()
        hiddenRightView.removeFromSuperview()
        hiddenLeftView.removeFromSuperview()
        
        isViewAdd = .none
    }
    
    /*
     cellWillMoveOriginalPosition
     
     @indexPath : pin button 클릭한 경우에만 indexPath 전달 통해 animation 종료 후 delegate 실행 되도록 함
     */
    func willMoveOriginalPosition(){
        
        let originalFrame = CGRect(x: 0,
                                   y: frame.origin.y,
                                   width: bounds.size.width,
                                   height: bounds.size.height)
        
        moveBackHiddenView()
        UIView.animate(withDuration: 0.25,
                       animations: { self.frame = originalFrame },
                       completion: { _ in
            self.removeHiddenViews()
        })
        
        isClamp = false
    }
    
    func cellWillMoveOriginalPosition(_ indexPath : IndexPath){
        
        let originalFrame = CGRect(x: 0,
                                   y: frame.origin.y,
                                   width: bounds.size.width,
                                   height: bounds.size.height)
        
        moveBackHiddenView()
        
        UIView.animate(withDuration: 0.25,
                       animations: { self.frame = originalFrame },
                       completion: { _ in
            self.removeHiddenViews()
            self.delegate?.cellWillPin(indexPath)
        })
        
        isClamp = false
    }
    
}

extension TodoInSummaryTableViewCell{
    
    var dataIndex: Int?{
        let indexPath = (self.superview as? UITableView)?.indexPath(for: self)
        return indexPath!.row - 1
    }
    
    func getCellIndexPath() -> IndexPath?{
        return (self.superview as? UITableView)?.indexPath(for: self)
    }
    
    func hiddenSettingViewShow(){

        if(isViewAdd == .none && !isClamp){
            
            self.superview?.superview?.addSubview(hiddenView)
            self.superview?.superview?.addSubview(hiddenRightView)
            self.superview?.superview?.addSubview(hiddenLeftView)
            
            self.superview?.superview?.sendSubviewToBack(hiddenRightView)
            self.superview?.superview?.sendSubviewToBack(hiddenLeftView)
            self.superview?.superview?.sendSubviewToBack(hiddenView)
            
            hiddenView.snp.makeConstraints{ make in
                make.leading.equalToSuperview().offset(32)
                make.trailing.equalToSuperview().offset(-30)
                make.height.equalTo(60)
                make.top.equalTo(backgroundShadowView)
                make.bottom.equalTo(backgroundShadowView)
            }
            
            hiddenRightView.snp.makeConstraints{ make in
                make.trailing.equalToSuperview().offset(-30)
                make.top.equalTo(backgroundShadowView)
                make.bottom.equalTo(backgroundShadowView)
            }
            
            hiddenLeftView.snp.makeConstraints{ make in
                make.leading.equalToSuperview().offset(32)
                make.top.equalTo(backgroundShadowView)
                make.bottom.equalTo(backgroundShadowView)
            }
        }
    }
    
    @objc func checkBoxDidClicked(){
        guard let index = dataIndex else { return }
        requestDelegate.requestPatchTodoCheckStatus(index: index)
    }
    
    @objc func alarmBtnDidClicked(_ sender : UIButton){
        
        guard let indexPath = getCellIndexPath() else { return }
        
        delegate?.cellWillAlarmEnabled(indexPath)
        
        willMoveOriginalPosition()
    }
    
    @objc func deleteButtonDidClicked(){
        willMoveOriginalPosition()
        requestDelegate.requestDeleteTodo(cell: self)
    }
    
    @objc func pinButtonDidClicked(){
        guard let indexPath = getCellIndexPath() else { return }
        cellWillMoveOriginalPosition(indexPath)
    }
}

extension TodoInSummaryTableViewCell{
    
    func setUpViewByCase(){
        
        titleLabel.snp.makeConstraints{ make in
            make.leading.equalTo(checkBox.snp.trailing).offset(13)
            make.centerY.equalToSuperview().offset(1.4)
        }

        categoryButton.snp.makeConstraints{ make in
            make.width.equalTo(todo.categoryWidth)
            make.height.equalTo(21)
            make.centerY.equalToSuperview().offset(1)
        }
        
        let titleTrailing: Int = todo.categoryWidth + 6
        
        if(todo.isAlarmEnabled){
            
            self.backgroundShadowView.addSubview(timeLabel)
            
            timeLabel.snp.makeConstraints{ make in
                make.trailing.equalToSuperview().offset(-18)
                make.centerY.equalToSuperview().offset(2)
                make.height.equalTo(15)
            }
            
            alarmImageConstraint()
            
            
            if(todo.isPinned!){
                
                alarmImage.snp.makeConstraints{ make in
                    make.trailing.equalTo(timeLabel.snp.leading).offset(-2)
                }
                
                pinImageConstraint()
                
                pinImage.snp.makeConstraints{ make in
                    make.trailing.equalTo(alarmImage.snp.leading).offset(-2)
                }
                categoryButton.snp.makeConstraints{ make in
                    make.trailing.equalTo(pinImage.snp.leading).offset(-3)
                }
 
                titleLabel.snp.updateConstraints{ make in
                    make.leading.equalTo(checkBox.snp.trailing).offset(7)
                }
                
                titleLabel.snp.makeConstraints{ make in
                    make.trailing.equalToSuperview().offset( -(titleTrailing + 100))
                }
            }else{
                
                alarmImage.snp.makeConstraints{ make in
                    make.trailing.equalTo(timeLabel.snp.leading).offset(-4)
                }
                
                categoryButton.snp.makeConstraints{ make in
                    make.trailing.equalTo(alarmImage.snp.leading).offset(-7)
                }
                
                titleLabel.snp.makeConstraints{ make in
                    make.trailing.equalToSuperview().offset(-(titleTrailing + 90)) //160
                }
            }
        }else{
            if(todo.isPinned!){
                
                pinImageConstraint()
                
                pinImage.snp.makeConstraints{ make in
                    make.trailing.equalToSuperview().offset(-18)
                }
                categoryButton.snp.makeConstraints{ make in
                    make.trailing.equalTo(pinImage.snp.leading).offset(-7)
                }
                titleLabel.snp.makeConstraints{ make in
                    make.trailing.equalToSuperview().offset(-(titleTrailing + 34))
                }
            }else{
                categoryButton.snp.makeConstraints{ make in
                    make.trailing.equalToSuperview().offset(-18)
                }
                titleLabel.snp.makeConstraints{ make in
                    make.trailing.equalToSuperview().offset(-(titleTrailing + 18))
                }
            }
        }
    }
    
    func pinImageConstraint(){
        
        self.backgroundShadowView.addSubview(pinImage)
        
        pinImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
            make.height.equalTo(13.2)
            make.centerY.equalToSuperview().offset(1)
        }
    }
    
    func alarmImageConstraint(){
        
        self.backgroundShadowView.addSubview(alarmImage)
        
        alarmImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
            make.height.equalTo(13.2)
            make.centerY.equalToSuperview().offset(0.6)
        }
    }

}
