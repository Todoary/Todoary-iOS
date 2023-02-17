//
//  TodoTitleInSummaryTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

protocol SummaryViewControllerDelegate{
    func willShowAddTodoOrDiaryButton()
    func willMoveCategoryViewController()
}

final class TodoTitleInSummaryTableViewCell: BaseTableViewCell {

    var delegate: SummaryViewControllerDelegate!
    
    private let todoListTitle = UILabel().then{
        $0.text = "TODO LIST"
        $0.setTypoStyleWithSingleLine(typoStyle: .extrabold12)
        $0.textColor = .summaryTitle
    }
    private let titleBackgroundView = ShadowView(cornerRadius: 24/2)
    
    private let buttonStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 0
    }
    private let addPlanButton = UIButton().then{
        $0.setImage(Image.todoPlus, for: .normal)
    }
    private let moveCategoryButton = UIButton().then{
        $0.setImage(Image.category, for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func style() {
        super.style()
        self.backgroundColor = .transparent
        self.selectedBackgroundView?.backgroundColor = .transparent
    }
    
    override func hierarchy() {
        
        super.hierarchy()
        
        baseView.addSubview(titleBackgroundView)
        baseView.addSubview(buttonStackView)
        
        titleBackgroundView.addSubview(todoListTitle)
        
        buttonStackView.addArrangedSubview(addPlanButton)
        buttonStackView.addArrangedSubview(moveCategoryButton)
    }
    
    override func layout() {
        
        super.layout()
        
        baseView.snp.makeConstraints{
            $0.height.equalTo(59)
        }
        
        todoListTitle.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        titleBackgroundView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(32)
            $0.bottom.equalToSuperview().offset(-16)
            $0.width.equalTo(todoListTitle).offset(24)
            $0.height.equalTo(24)
        }
        
        buttonStackView.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-23)
            $0.top.bottom.equalToSuperview()
        }
        addPlanButton.snp.makeConstraints{
            $0.width.equalTo(43)
            $0.height.equalTo(59)
        }
        moveCategoryButton.snp.makeConstraints{
            $0.width.equalTo(43)
            $0.height.equalTo(59)
        }
    }
    
    private func initialize(){
        addPlanButton.addTarget(self, action: #selector(addTodoOrDiaryButtonDidTapped), for: .touchUpInside)
        moveCategoryButton.addTarget(self, action: #selector(moveCategoryButtonDidClicked), for: .touchUpInside)
    }
    
    @objc private func addTodoOrDiaryButtonDidTapped(){
        delegate?.willShowAddTodoOrDiaryButton()
    }
    
    @objc private func moveCategoryButtonDidClicked(){
        delegate?.willMoveCategoryViewController()
    }
}
