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
    
    let homeBorderLine1 = UIView().then{
        $0.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1)
    }
    
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
    
    let homeBorderLine2 = UIView().then{
        $0.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1)
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
    
    let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isPagingEnabled = true
    }
    
    let weekCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 21, bottom: 0, right: 21)
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 2)
        $0.collectionViewLayout = layout
    }
    
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 21, bottom: 0, right: 21)
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 2)
        $0.collectionViewLayout = layout
    }
    
    let previousCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 21, bottom: 0, right: 21)
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 2)
        $0.collectionViewLayout = layout
    }
    
    let nextCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 21, bottom: 0, right: 21)
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 2)
        $0.collectionViewLayout = layout
    }
    
    override func hierarchy(){
        
        self.addSubview(settingButton)
        self.addSubview(logo)
        
        self.addSubview(homeBorderLine1)
        
        self.addSubview(profileImage)
        self.addSubview(nickname)
        self.addSubview(introduce)
        
        self.addSubview(homeBorderLine2)
        
        self.addSubview(year_Month)
        self.addSubview(previousMonthButton)
        self.addSubview(nextMonthButton)
        
        self.addSubview(weekCollectionView)
        
        self.addSubview(scrollView)
        
        scrollView.addSubview(previousCollectionView)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(nextCollectionView)

       
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
        
        homeBorderLine1.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.equalTo(profileImage.snp.leading).offset(-10)
            make.trailing.equalTo(settingButton.snp.trailing).offset(-4)
            make.top.equalTo(logo.snp.bottom).offset(17)
        }
        
        //profile
        profileImage.snp.makeConstraints{ make in
            make.top.equalTo(homeBorderLine1.snp.bottom).offset(12)
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
        
        homeBorderLine2.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.equalTo(profileImage.snp.leading).offset(-10)
            make.trailing.equalTo(settingButton.snp.trailing).offset(-4)
            make.top.equalTo(profileImage.snp.bottom).offset(12)
        }
        
        year_Month.snp.makeConstraints{ make in
            make.top.equalTo(homeBorderLine2.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(45)
            make.width.equalTo(100)
            make.height.equalTo(22)
        }
        
        let screenSize = UIScreen.main.bounds
        
        weekCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(year_Month.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(screenSize.width)
            make.height.equalTo(23)
        }
        
        scrollView.snp.makeConstraints{ make in
            make.top.equalTo(weekCollectionView.snp.bottom).offset(5)
            make.width.equalTo(screenSize.width * 3)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(500)
        }
        
        previousCollectionView.snp.makeConstraints{ make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.equalTo(collectionView.snp.leading)
            make.width.equalTo(screenSize.width)
            make.height.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(previousCollectionView.snp.trailing)
            make.trailing.equalTo(nextCollectionView.snp.leading)
            make.width.equalTo(screenSize.width)
            make.height.equalToSuperview()
        }
        
        nextCollectionView.snp.makeConstraints{ make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(collectionView.snp.trailing)
            make.width.equalTo(screenSize.width)
            make.height.equalToSuperview()
        }
    }
}

        
