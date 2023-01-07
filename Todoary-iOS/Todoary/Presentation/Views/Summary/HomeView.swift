//
//  HomeView.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import SnapKit


class HomeView: BaseView{
    
    //MARK: - UIComponenets

    //settingBtn
    
    let settingButton = UIButton().then{
        $0.setImage(UIImage(named: "homemenu"), for: .normal)
    }
    
    //todoaryLogo
    
    let logo = UIImageView().then{
        $0.image = UIImage(named: "home_apptitle")
    }
    
    //profile
    
    let profileImage = UIButton().then {
        $0.imageView?.contentMode = .scaleAspectFill
        $0.setImage(UIImage(named: "home_profile"),for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40/2
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1).cgColor
    }
    
    let nickname = paddingLabel().then{
        $0.layer.backgroundColor = UIColor.calendarExistColor.cgColor
        $0.layer.cornerRadius = 6
        $0.textAlignment = .center
        $0.text = ""
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(ofSize: 14, weight: .semibold)
    }
    
    let introduce = UILabel().then{
        $0.text = ""
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.24)
        $0.font = UIFont.nbFont(type: .sub1)
    }
    
    lazy var year_Month = UIButton().then{
        $0.setTitle("2022년 8월", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 18, weight: .bold)
        $0.titleLabel?.textAlignment = .left
        $0.contentHorizontalAlignment = .left
    }
    
    lazy var previousMonthButton = UIButton().then{
        $0.setImage(UIImage(named: "home_previous"), for: .normal)
    }
    
    lazy var nextMonthButton = UIButton().then{
        $0.setImage(UIImage(named: "home_next"), for: .normal)
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 2)
        $0.collectionViewLayout = layout
    }
    
    override func hierarchy(){
        
        self.addSubview(settingButton)
        self.addSubview(logo)
        
        self.addSubview(profileImage)
        self.addSubview(nickname)
        self.addSubview(introduce)
        
        self.addSubview(year_Month)
        self.addSubview(previousMonthButton)
        self.addSubview(nextMonthButton)
        
        self.addSubview(collectionView)

       
    }
    
    
    override func layout(){
        
        //settingBtn
        settingButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(52)
            make.trailing.equalToSuperview().offset(-25)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        //logo
        logo.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(52)
            make.leading.equalToSuperview().offset(42)
            make.width.equalTo(90)
            make.height.equalTo(24)
        }
        
        //profile
        profileImage.snp.makeConstraints{ make in
            make.top.equalTo(logo.snp.bottom).offset(29)
            make.leading.equalToSuperview().offset(41)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        nickname.snp.makeConstraints{ make in
            make.top.equalTo(profileImage)
            make.leading.equalTo(profileImage.snp.trailing).offset(10)
            make.height.equalTo(21)
        }
        
        introduce.snp.makeConstraints{ make in
            make.top.equalTo(nickname.snp.bottom).offset(4)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        year_Month.snp.makeConstraints{ make in
            make.top.equalTo(profileImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(45)
            make.width.equalTo(100)
            make.height.equalTo(22)
        }
        
        previousMonthButton.snp.makeConstraints{ make in
            make.centerY.equalTo(year_Month)
            make.trailing.equalTo(nextMonthButton.snp.leading).offset(-13)
        }
        
        nextMonthButton.snp.makeConstraints{ make in
            make.centerY.equalTo(year_Month)
            make.trailing.equalToSuperview().offset(-33)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(year_Month.snp.bottom).offset(17)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
                .offset(28)
            make.trailing.equalToSuperview()
                .offset(-28)
            make.bottom.equalToSuperview()
        }
    }
}

        
