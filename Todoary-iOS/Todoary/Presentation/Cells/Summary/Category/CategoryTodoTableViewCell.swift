//
//  CategoryTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryTodoTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    var todoData: GetTodoInfo!
    
    //MARK: - UI

    static let cellIdentifier = "todoCell"
    
    var navigation: UINavigationController!
    
    var viewController: CategoryViewController!
    
    lazy var categoryLabel = UIButton().then{
        $0.titleEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 3, right: 0)
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .bold)
        $0.layer.cornerRadius = 21/2
    }
    
    lazy var checkBox = UIButton().then{
        $0.setImage(UIImage(named: "todo_check_empty"), for: .normal)
        $0.setImage(UIImage(named: "todo_check"), for: .selected)
        $0.addTarget(self, action: #selector(checkBoxDidClicked(_:)), for: .touchUpInside)
    }
    
    lazy var todoTitle = UILabel().then{
        $0.text  = "운동"
        $0.numberOfLines = 0
        $0.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.addLetterSpacing(spacing: 0.3)
        $0.setTextWithLineHeight(lineHeight: 22)
        $0.textColor = .black
        
    }
    
    let dateLabel = UILabel().then{
        $0.textAlignment = .right
        $0.font = UIFont.nbFont(ofSize: 13, weight: .medium)
        $0.textColor = .timeColor
    }
    
    lazy var timeLabel = UILabel().then{
        $0.textAlignment = .center
        $0.textColor = .timeColor
        $0.font = UIFont.nbFont(ofSize: 13, weight: .medium)
    }
    
    lazy var alarmImage = UIImageView().then{
        $0.image = UIImage(named: "notifications")
        $0.contentMode = .scaleAspectFit
    }
    
    let timeView = UIStackView().then{
        $0.spacing = 4
        $0.axis = .horizontal
        $0.alignment = .top
    }
    
    let timeStack = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 7.86
        $0.alignment = .trailing
    }
    
    let backView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowRadius = 7.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    let selectedView = UIView().then{
        $0.backgroundColor = .white
    }

    lazy var deleteButton = UIButton().then{
        $0.setImage(UIImage(named: "minus"), for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(deleteButtonDidClicked), for: .touchUpInside)
    }
    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectedBackgroundView = selectedView
        
        setUpView()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
        todoTitle.text = ""
        dateLabel.text = ""
        timeLabel.text = ""
        
        checkBox.isSelected = false
        
        alarmImage.removeFromSuperview()
        timeView.removeFromSuperview()
        
        categoryLabel.setTitle("", for: .normal)
        categoryLabel.setTitleColor(.white, for: .normal)
        categoryLabel.layer.borderColor = UIColor.white.cgColor
    }
    
    //MARK: - Action
    
    @objc
    func checkBoxDidClicked(_ sender: UIButton){
        let parameter = TodoCheckboxInput(todoId: todoData.todoId, isChecked: !sender.isSelected)
        TodoCheckboxDataManager().patch(cell: self, parameter: parameter)
    }
    
    @objc
    func deleteButtonDidClicked(){
        guard let tableView = (self.superview as? UITableView) else{ fatalError() }
        let indexPath = tableView.indexPath(for: self)!
        TodoDeleteDataManager().delete(viewController: self.viewController, todoId: self.todoData.todoId, indexPath: indexPath)
    }
    
    //MARK: - Helper
    
    func settingTodoData(_ cellData: GetTodoInfo){
        
        self.todoData = cellData
        
        self.todoTitle.text = self.todoData.title
        self.dateLabel.text = cellData.convertDate
        self.timeLabel.text = cellData.convertTime ?? ""
        self.checkBox.isSelected = cellData.isChecked ?? false
        self.setUpTimeStack()
        self.setCategoryData()
    }
    
    func setCategoryData(){
        self.categoryLabel.setTitle(todoData.categoryTitle, for: .normal)
        self.categoryLabel.layer.borderColor = UIColor.categoryColor[todoData.color].cgColor
        self.categoryLabel.setTitleColor( UIColor.categoryColor[todoData.color], for: .normal)
    }
    
    //MARK: - API
    
    func checkSendCheckboxApiResultCode(_ code: Int){
        switch code{
        case 1000:
            print("성공")
            checkBox.isSelected.toggle()
            return
        default:
            let alert = DataBaseErrorAlert()
            navigation.present(alert, animated: true, completion: nil)
        }
    }
}
