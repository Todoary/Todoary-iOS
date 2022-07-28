//
//  TodoListTitleCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class TodoListTitleCell: UITableViewCell {
    
    static let cellIdentifier = "todolistTitleCell"
    
    var homeVC : TodoListBottomSheetViewController!
    
    let backView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    let selectedBackView = UIView().then{
        $0.backgroundColor = .transparent
    }

    let todoListTitle = UILabel().then{
        $0.text = "TODO LIST"
        $0.font = UIFont.nbFont(ofSize: 12, weight: .extraBold)
        $0.textColor = .summaryTitle
        $0.addLetterSpacing(spacing: 0.24)
    }
    
    let titleBackgroundView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24/2
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    let addPlanButton = UIButton().then{
        $0.setImage(UIImage(named: "todo_plus"), for: .normal)
        $0.addTarget(self, action: #selector(addPlanButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    let moveCategoryButton = UIButton().then{
        $0.setImage(UIImage(named: "category"), for: .normal)
        $0.addTarget(self, action: #selector(moveCategoryButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    let buttonStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .transparent
        self.selectedBackgroundView = selectedBackView
        
        setUpView()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func addPlanButtonDidClicked(_ sender: UIButton){
        
        print("add plan button did cliked")
        
        let vc = TodoSettingViewController()
        homeVC.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func moveCategoryButtonDidClicked(_ sender: UIButton){
        print("move category button did cliked")
    }
    
    func setUpView(){
        
        self.contentView.addSubview(backView)
        
        buttonStackView.addArrangedSubview(addPlanButton)
        buttonStackView.addArrangedSubview(moveCategoryButton)
        
        backView.addSubview(titleBackgroundView)
        titleBackgroundView.addSubview(todoListTitle)
        backView.addSubview(buttonStackView)
        
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(59)
            make.width.equalToSuperview()
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        todoListTitle.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
        
        titleBackgroundView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(84)
            make.height.equalTo(24)
        }
        
        buttonStackView.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-23)
        }
        
        addPlanButton.snp.makeConstraints{ make in
            make.width.equalTo(43)
            make.height.equalTo(59)
        }
        
        moveCategoryButton.snp.makeConstraints{ make in
            make.width.equalTo(43)
            make.height.equalTo(59)
        }
    }
}
