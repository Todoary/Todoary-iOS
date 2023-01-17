//
//  TodoListTableViewCell+Layout.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/17.
//

import Foundation

extension TodoInSummaryTableViewCell{
    
    func setUpView(){
        
        self.contentView.addSubview(backView)
        
        self.backView.addSubview(checkBox)
        self.backView.addSubview(titleLabel)
        self.backView.addSubview(categoryButton)
    
        self.selectedBackgroundView = selectedBackView
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(75)
            make.top.equalToSuperview().offset(7.5)
            make.bottom.equalToSuperview().offset(-7.5)
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        checkBox.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().offset(19)
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
        }

    }
    
    func setUpViewByCase(){
        
        titleLabel.snp.makeConstraints{ make in
            make.leading.equalTo(checkBox.snp.trailing).offset(13)
            make.centerY.equalToSuperview().offset(1.4)
        }

        categoryButton.snp.makeConstraints{ make in
            make.width.equalTo(cellData.categoryWidth)
            make.height.equalTo(21)
            make.centerY.equalToSuperview().offset(1)
        }
        
        let titleTrailing: Int = cellData.categoryWidth + 6
        
        if(cellData.isAlarmEnabled){
            
            self.backView.addSubview(timeLabel)
            
            timeLabel.snp.makeConstraints{ make in
                make.trailing.equalToSuperview().offset(-18)
                make.centerY.equalToSuperview().offset(2)
                make.height.equalTo(15)
            }
            
            alarmImageConstraint()
            
            
            if(cellData.isPinned!){
                
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
            if(cellData.isPinned!){
                
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
        
        self.backView.addSubview(pinImage)
        
        pinImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
            make.height.equalTo(13.2)
            make.centerY.equalToSuperview().offset(1)
        }
    }
    
    func alarmImageConstraint(){
        
        self.backView.addSubview(alarmImage)
        
        alarmImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
            make.height.equalTo(13.2)
            make.centerY.equalToSuperview().offset(0.6)
        }
    }

}
