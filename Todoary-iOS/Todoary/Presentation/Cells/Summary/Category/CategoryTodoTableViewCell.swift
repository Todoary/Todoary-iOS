//
//  CategoryTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

protocol CategoryTodoCellDelegate{
    func requestDeleteTodo(cell: CategoryTodoTableViewCell)
    func requestPatchTodoCheckStatus(cell: CategoryTodoTableViewCell)
}

class CategoryTodoTableViewCell: BaseTableViewCell {
    
    var delegate: CategoryTodoCellDelegate?
    
    //MARK: - UI
    
    let backgroundShadowView = ShadowView(cornerRadius: 20)
    private let categoryLabel = CategoryTag.generateForCategoryTodo()
    
    private lazy var checkBox = UIButton().then{
        $0.setImage(Image.todoCheckEmpty, for: .normal)
        $0.setImage(Image.todoCheck, for: .selected)
        $0.addTarget(self, action: #selector(willChangeCheckBoxState), for: .touchUpInside)
    }
    
    private lazy var todoTitle = UILabel().then{
        $0.text  = "운동"
        $0.numberOfLines = 0
        $0.setTypoStyleWithMultiLine(typoStyle: .bold15_22)
        $0.textColor = .black
    }
    
    private let dateLabel = UILabel().then{
        $0.textAlignment = .right
        $0.setTypoStyleWithSingleLine(typoStyle: .medium13)
        $0.textColor = .timeColor
    }
    
    private lazy var timeLabel = UILabel().then{
        $0.textAlignment = .center
        $0.textColor = .timeColor
        $0.setTypoStyleWithSingleLine(typoStyle: .medium13)
    }
    
    private lazy var alarmImage = UIImageView().then{
        $0.image = Image.notifications
        $0.contentMode = .scaleAspectFit
    }
    
    private let timeView = UIStackView().then{
        $0.spacing = 4
        $0.axis = .horizontal
        $0.alignment = .top
    }
    
    private let timeStack = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 7.86
        $0.alignment = .trailing
    }

    lazy var deleteButton = UIButton().then{
        $0.setImage(Image.minus, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(deleteButtonDidTapped), for: .touchUpInside)
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
    
    override func hierarchy() {
        
        super.hierarchy()
        
        self.addSubview(deleteButton)
        baseView.addSubview(backgroundShadowView)
        
        backgroundShadowView.addSubview(categoryLabel)
        backgroundShadowView.addSubview(checkBox)
        backgroundShadowView.addSubview(todoTitle)
        backgroundShadowView.addSubview(timeStack)
        
        timeStack.addArrangedSubview(dateLabel)
    }
    
    override func layout() {

        contentView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        baseView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalToSuperview()
            $0.height.equalTo(backgroundShadowView).offset(20)
        }
        backgroundShadowView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(todoTitle).offset(68)
        }
        
        categoryLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(19)
            $0.top.equalToSuperview().offset(14)
            $0.height.equalTo(21)
            $0.width.equalTo(categoryLabel.titleLabel!).offset(22)
        }
        
        checkBox.snp.makeConstraints{
            $0.width.height.equalTo(22)
            $0.top.equalToSuperview().offset(44.36)
            $0.leading.equalToSuperview().offset(19)
        }
        
        todoTitle.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-101)
            $0.centerY.equalTo(checkBox)
            $0.leading.equalTo(checkBox.snp.trailing).offset(9)
        }
        
        
        timeStack.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-18)
            $0.bottom.equalToSuperview().offset(-23)
        }
        
        dateLabel.snp.makeConstraints{
            $0.width.equalTo(71)
            $0.height.equalTo(14.14)
        }
        
        deleteButton.snp.makeConstraints{
            $0.width.height.equalTo(22)
            $0.leading.equalToSuperview().offset(17)
            $0.centerY.equalTo(backgroundShadowView)
        }
    }
    
    //MARK: - Action
    
    @objc private func willChangeCheckBoxState(){
        delegate?.requestPatchTodoCheckStatus(cell: self)
    }
    
    @objc private func deleteButtonDidTapped(){
        delegate?.requestDeleteTodo(cell: self)
    }

    func bindingData(_ todo: TodoResultModel){
        todoTitle.text = todo.title
        dateLabel.text = todo.convertDate
        timeLabel.text = todo.convertTime ?? ""
        checkBox.isSelected = todo.isChecked
        categoryLabel.bindingData(title: todo.categoryTitle, color: todo.color)
        if(todo.isAlarmEnabled){
            setUpTimeStack()
        }
    }
    
    private func setUpTimeStack(){
        timeStack.addArrangedSubview(timeView)
        timeView.addArrangedSubview(alarmImage)
        timeView.addArrangedSubview(timeLabel)
        
        alarmImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
        }
    }
}
