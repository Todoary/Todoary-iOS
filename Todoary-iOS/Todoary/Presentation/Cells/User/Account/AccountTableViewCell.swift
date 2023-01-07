//
//  AccountCollectionViewCell.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/10.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    static let identifier = "accountTableViewCell"
    
    //MARK: - UIComponents
    
    let main = UIView().then{
        $0.backgroundColor = .white
    }
    
    let title = UILabel().then{
        $0.text = "비밀번호 재설정"
        $0.textColor = .black
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let nextBtn = UIButton().then{
        $0.setImage(UIImage(named: "next_btn"), for: .normal)
    }
    
    let borderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    //MARK: - Lifecycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
            
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setUpView()
            setUpConstraint()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    private func setUpView(){
        self.contentView.addSubview(main)
        self.main.addSubview(title)
        self.main.addSubview(nextBtn)
        self.main.addSubview(borderLine)
    }
    
    //MARK: - UIContraints
    
    private func setUpConstraint(){
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
        
        main.snp.makeConstraints{ make in
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
        
        title.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(31)
            make.centerY.equalToSuperview()
        }
        
        nextBtn.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-31)
            make.centerY.equalToSuperview()
        }
        
        borderLine.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(1)
        }
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
              contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
}
