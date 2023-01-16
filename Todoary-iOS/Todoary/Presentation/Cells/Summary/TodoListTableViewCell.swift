//
//  TodoListTableViewCell.swift
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

class TodoListTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let cellIdentifier = "todoListCell"
    
    weak var delegate : SelectedTableViewCellDeliver?
    
    var navigation : UINavigationController!
    
    var cellData : TodoResultModel!
    
    //MARK: - Properties(for swipe)
    
    //new ver.
    lazy var leftWidth : CGFloat = 105
    lazy var rightWidth : CGFloat = 58
    
    //hiddenView addSubView 되었는지 아닌지 확인 용도
    lazy var isViewAdd : CurrentHidden = .none
    
    lazy var originalCenter = CGPoint()
    lazy var isClamp = false
    
    //MARK: - UI
    
    lazy var checkBox = UIButton().then{
        $0.setImage(UIImage(named: "todo_check_empty"), for: .normal)
        $0.setImage(UIImage(named: "todo_check"), for: .selected)
        $0.addTarget(self, action: #selector(checkBoxDidClicked(_:)), for: .touchUpInside)
    }
    
    let titleLabel = UILabel().then{
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.addLetterSpacing(spacing: 0.3)
    }
    
    lazy var categoryButton = UIButton().then{
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .bold)
        $0.addLetterSpacing(spacing: 0.24)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 21/2
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 1, bottom: 3, right: 0)
        $0.titleLabel?.textAlignment = .center
        $0.isEnabled = false
    }
    
    lazy var pinImage = UIImageView().then{
        $0.image = UIImage(named: "push_pin")
    }
    
    lazy var alarmImage = UIImageView().then{
        $0.image = UIImage(named: "notifications")
    }
    
    let timeLabel = UILabel().then{
        $0.textColor = .timeColor
        $0.font = UIFont.nbFont(ofSize: 13, weight: .medium)
        $0.addLetterSpacing(spacing: -0.26)
    }
    
    let backView = UIView().then{
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .white
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    lazy var hiddenLeftView = HiddenLeftButtonView().then{
        $0.pinButton.addTarget(self, action: #selector(pinButtonDidClicked(_:)), for: .touchUpInside)
        $0.alarmBtn.addTarget(self, action: #selector(alarmBtnDidClicked(_:)), for: .touchUpInside)
    }
    
    lazy var hiddenRightView = HiddenRightButtonView().then{
        $0.deleteButton.addTarget(self, action: #selector(deleteButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    lazy var hiddenView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
        
        $0.snp.makeConstraints{ make in
            make.height.equalTo(60)
        }
    }
    
    let selectedBackView = UIView().then{
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    //MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
     
        setUpView()
        setUpConstraint()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        swipeGesture.delegate = self
        backView.addGestureRecognizer(swipeGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellDidTapped))
        tapGesture.delegate = self
        backView.addGestureRecognizer(tapGesture)
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
    }
    
    //MARK: - Method
    
    func cellWillSettingWithData(){
        
        titleLabel.text = cellData.title
        timeLabel.text = cellData.convertTime
        checkBox.isSelected = cellData.isChecked ?? false
        
        self.categoryButton.setTitle(cellData.categoryTitle, for: .normal)
        self.categoryButton.layer.borderColor = UIColor.categoryColor[cellData.color].cgColor
        self.categoryButton.setTitleColor(UIColor.categoryColor[cellData.color], for: .normal)
        
        hiddenLeftView.pinButton.isSelected = cellData.isPinned! ? true : false
        hiddenLeftView.alarmBtn.isSelected = cellData.isAlarmEnabled ? true : false
        
        setUpViewByCase()
        
    }
    
    @objc func cellDidTapped(){
        
        guard let indexPath = getCellIndexPath() else { fatalError("indexPath casting error") }
        
        delegate?.cellDidTapped(indexPath)
    }
    
}

//MARK: - Swipe Method
extension TodoListTableViewCell{

    @objc
    func handlePan(_ recognizer: UIPanGestureRecognizer){

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
                cellWillMoveOriginalPosition()
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
        
        if let tapGesture = gestureRecognizer as? UITapGestureRecognizer{
            return true
        }
        return false
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.backView) == true {
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
    func cellWillMoveOriginalPosition(){
        
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

extension TodoListTableViewCell{
    
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
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
            }
            
            hiddenRightView.snp.makeConstraints{ make in
                make.trailing.equalToSuperview().offset(-30)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
            }
            
            hiddenLeftView.snp.makeConstraints{ make in
                make.leading.equalToSuperview().offset(32)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
            }
        }
    }
    
    @objc
    func checkBoxDidClicked(_ sender: UIButton){
        
        let parameter = TodoCheckboxInput(todoId: cellData.todoId, isChecked: !sender.isSelected)
        
        TodoCheckboxDataManager().patch(indexPath: getCellIndexPath()!, parameter: parameter)
    }
    
    @objc
    func alarmBtnDidClicked(_ sender : UIButton){
        
        guard let indexPath = getCellIndexPath() else { return }
        
        delegate?.cellWillAlarmEnabled(indexPath)
        
        cellWillMoveOriginalPosition()
    }
    
    @objc
    func deleteButtonDidClicked(_ sender : UIButton){
        
        guard let indexPath = getCellIndexPath() else { return }

        cellWillMoveOriginalPosition()
        
        TodoDeleteDataManager().delete(todoId: cellData.todoId, indexPath: indexPath)
    }
    
    @objc
    func pinButtonDidClicked(_ sender : UIButton){
        
        guard let indexPath = getCellIndexPath() else { return }
        
        cellWillMoveOriginalPosition(indexPath)
    }
}

protocol SelectedTableViewCellDeliver: AnyObject{
    func cellDidTapped(_ indexPath: IndexPath)
    func cellWillAlarmEnabled(_ indexPath: IndexPath)
    func cellWillPin(_ indexPath: IndexPath)
    func cellWillClamp(_ indexPath: IndexPath)
}

