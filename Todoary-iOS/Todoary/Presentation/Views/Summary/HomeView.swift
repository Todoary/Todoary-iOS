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
    
    private let isSmallDevice = Const.Device.isSmallDevice

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
        let profileImageHeight: CGFloat = Const.Device.isSmallDevice ? 32 : 40
        $0.layer.cornerRadius = profileImageHeight/2
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1).cgColor
    }
    
    let nickname = paddingLabel().then{
        $0.layer.backgroundColor = UIColor.calendarExistColor.cgColor
        $0.layer.cornerRadius = 6
        $0.textAlignment = .center
        $0.text = ""
        $0.textColor = .black
        let kern: CGFloat = Const.Device.isSmallDevice ? 0.23 : 0.28
        $0.addLetterSpacing(spacing: kern)
        let font: CGFloat = Const.Device.isSmallDevice ? 11.5 : 14
        $0.font = UIFont.nbFont(ofSize: font, weight: .semibold)
    }
    
    let introduce = UILabel().then{
        $0.text = ""
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.2)
        let font: CGFloat = Const.Device.isSmallDevice ? 9.87 : 12
        $0.font = UIFont.nbFont(ofSize: font, weight: .medium)
    }
    
    let homeBorderLine2 = UIView().then{
        $0.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1)
    }
    
    lazy var year_Month = UIButton().then{
        $0.setTitle("2022년 8월", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        let font: TypoStyle = Const.Device.isSmallDevice ? .bold14 : .bold18
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: font)
        $0.titleLabel?.textAlignment = .left
        $0.contentHorizontalAlignment = .left
    }
    
    
    let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isPagingEnabled = true
    }
    
    
    let weekCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let collectionViewInset = Const.Device.isSmallDevice ? 13.0 : 19
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: collectionViewInset, bottom: 0, right: collectionViewInset)
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 2)
        $0.collectionViewLayout = layout
    }
    
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let collectionViewInset = Const.Device.isSmallDevice ? 13.0 : 19
        layout.sectionInset = UIEdgeInsets.init(top: 3, left: collectionViewInset, bottom: 0, right: collectionViewInset)
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 2)
        $0.collectionViewLayout = layout
    }
    
    let previousCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let collectionViewInset = Const.Device.isSmallDevice ? 13.0 : 19
        layout.sectionInset = UIEdgeInsets.init(top: 3, left: collectionViewInset, bottom: 0, right: collectionViewInset)
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 2)
        $0.collectionViewLayout = layout
    }
    
    let nextCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let collectionViewInset = Const.Device.isSmallDevice ? 13.0 : 19
        layout.sectionInset = UIEdgeInsets.init(top: 3, left: collectionViewInset, bottom: 0, right: collectionViewInset)
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
        
        self.addSubview(weekCollectionView)
        
        self.addSubview(scrollView)
        
        scrollView.addSubview(previousCollectionView)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(nextCollectionView)

       
    }
    
    
    override func layout(){
        
        let borderLineHeight = isSmallDevice ? 0.82 : 1
        let settingButtonTrailing = isSmallDevice ? 20.24 : 25
        let collectionViewTop = isSmallDevice ? 10 : 14
        
        //settingBtn
        settingButton.snp.makeConstraints{ make in
            let settingButtonTop = isSmallDevice ? 48 : 52
            make.top.equalToSuperview().offset(settingButtonTop)
            make.trailing.equalToSuperview().offset(-settingButtonTrailing)
            let settingButtonSize = isSmallDevice ? 20.56 : 25
            make.width.equalTo(settingButtonSize)
            make.height.equalTo(settingButtonSize)
        }
        
        //logo
        logo.snp.makeConstraints{ make in
            make.top.equalTo(settingButton.snp.top)
            let logoLeading = isSmallDevice ? 34.18 : 42
            make.leading.equalToSuperview().offset(logoLeading)
            let logoWidth = isSmallDevice ? 74 : 90
            make.width.equalTo(90)
            let logoHeight = isSmallDevice ? 19.73 : 24
            make.height.equalTo(24)
        }
        
        homeBorderLine1.snp.makeConstraints{ make in
            
            make.height.equalTo(borderLineHeight)
            make.leading.equalTo(profileImage.snp.leading).offset(-10)
            make.trailing.equalTo(settingButton.snp.trailing).offset(-4)
            let borderLine2Top = isSmallDevice ? 13.98 : 17
            make.top.equalTo(logo.snp.bottom).offset(borderLine2Top)
        }
        
        //profile
        profileImage.snp.makeConstraints{ make in
            let profileImageTop = isSmallDevice ? 9.87 : 12
            make.top.equalTo(homeBorderLine1.snp.bottom).offset(profileImageTop)
            let profileImageLeading = isSmallDevice ? 33.36 : 41
            make.leading.equalToSuperview().offset(profileImageLeading)
            let profileImageSize = isSmallDevice ? 32.89 : 40
            make.width.equalTo(profileImageSize)
            make.height.equalTo(profileImageSize)
        }
        
        nickname.snp.makeConstraints{ make in
            make.top.equalTo(profileImage)
            let nicknameLeading = isSmallDevice ? 8.21 : 10
            make.leading.equalTo(profileImage.snp.trailing).offset(nicknameLeading)
            let nicknameHeight = isSmallDevice ? 17.29 : 21
            make.height.equalTo(nicknameHeight)
        }
        
        introduce.snp.makeConstraints{ make in
            make.top.equalTo(nickname.snp.bottom).offset(4)
            let introduceLeading = isSmallDevice ? 9.87 : 12
            make.leading.equalTo(profileImage.snp.trailing).offset(introduceLeading)
            make.trailing.equalToSuperview().offset(-settingButtonTrailing)
        }
        
        homeBorderLine2.snp.makeConstraints{ make in
            make.height.equalTo(borderLineHeight)
            make.leading.equalTo(profileImage.snp.leading).offset(-10)
            make.trailing.equalTo(settingButton.snp.trailing).offset(-4)
            let borderLine2Top = isSmallDevice ? 10.2 : 12
            make.top.equalTo(profileImage.snp.bottom).offset(borderLine2Top)
        }
        
        year_Month.snp.makeConstraints{ make in
            let year_MonthTop = isSmallDevice ? 10.69 : 13
            make.top.equalTo(homeBorderLine2.snp.bottom).offset(year_MonthTop)
            let year_MonthLeading = isSmallDevice ? 30.42 : 38
            make.leading.equalToSuperview().offset(year_MonthLeading)
            let year_MonthWidth = isSmallDevice ? 71 : 100
            make.width.equalTo(year_MonthWidth)
            let year_MonthHeight = isSmallDevice ? 18 : 22
            make.height.equalTo(year_MonthHeight)
        }
        
        let screenSize = UIScreen.main.bounds
        
        weekCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(year_Month.snp.bottom).offset(collectionViewTop)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(screenSize.width)
            make.height.equalTo(23)
        }
        
        scrollView.snp.makeConstraints{ make in
            make.top.equalTo(weekCollectionView.snp.bottom).offset(2)
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

        
