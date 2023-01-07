//
//  SettingViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit
import SnapKit
import Then

class SettingViewController : BaseViewController {
    
    //MARK: - UIComponenets
    
    //tableView
    var tableView : UITableView!
    
    //version
    let versionBorderLine1 = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let versionText = UILabel().then{
        $0.text = "버전"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .tableCell)
    }
    
    let versionNum = UILabel().then{
        $0.text = "1.0"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .tableCell)
    }
    
    let versionBorderLine2 = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        navigationTitle.text = "설정"
        
        tableView = UITableView().then{
            $0.separatorStyle = .none
            $0.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell")
            $0.isScrollEnabled = false
            $0.backgroundColor = .white
            
            $0.delegate = self
            $0.dataSource = self
        }

        setUpView()
        setUpConstraint()
    }
    
    @objc func backBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showDisabledFuncAlert(){
        let alert = ConfirmMessageAlertViewController(title: "다음 업데이트에 만나요!", message: "현재 버전에서는 제공하고 있지 않은 기능입니다.")
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)
    }
}


//MARK: - Helpers

extension SettingViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else{
            return UITableViewCell()
        }
        
        switch indexPath.row{
        case 0:
            cell.title.text = "알림"
            cell.img.image = UIImage(named: "Alarm")
            return cell
        case 1:
            cell.title.text = "화면"
            cell.img.image = UIImage(named: "screen")
            return cell
        case 2:
            cell.title.text = "계정"
            cell.img.image = UIImage(named: "account")
            return cell
        case 3:
            cell.title.text = "암호"
            cell.img.image = UIImage(named: "lock")
            return cell
        case 4:
            cell.title.text = "Todoary 가이드"
            cell.img.image = UIImage(named: "help")
            return cell
        case 5:
            cell.title.text = "약관 및 정책"
            cell.img.image = UIImage(named: "document")
            return cell
        case 6:
            cell.title.text = "문의하기"
            cell.img.image = UIImage(named: "feedback")
            return cell
        case 7:
            cell.title.text = "리뷰 남기기"
            cell.img.image = UIImage(named: "review")
            return cell
        default:
            fatalError("TableViewCell Error")
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            self.navigationController?.pushViewController(AlarmSettingViewController(), animated: true)
            return
        case 1:
            showDisabledFuncAlert()
//            self.navigationController?.pushViewController(ScreenSettingViewController(), animated: true)
            return
        case 2:
            self.navigationController?.pushViewController(AccountViewController(), animated: true)
            return
        case 3:
            self.navigationController?.pushViewController(PinNumberSettingViewController(), animated: true)
            return
        case 4:
            showDisabledFuncAlert()
            
           // self.navigationController?.pushViewController(SettingAgreementViewController(), animated: true)
            return
        case 5:
            self.navigationController?.pushViewController(SettingAgreementViewController(), animated: true)
            return
        case 6:
            self.navigationController?.pushViewController(AskViewController(), animated: true)
            return
        case 7:
            showDisabledFuncAlert()
            //self.navigationController?.pushViewController(SettingAgreementViewController(), animated: true)
            return
        default:
            return
        }
    }
}
