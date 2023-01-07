//
//  SettingAgreementViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit
import SnapKit
import Then

class SettingAgreementViewController : BaseViewController {
    
    //MARK: - UIComponenets

    let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    
    //tableView
    var tableView : UITableView!
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        navigationTitle.text = "약관 및 정책"
        
        tableView = UITableView().then{
            $0.separatorStyle = .none
            $0.register(SettingAgreementViewCell.self, forCellReuseIdentifier: "SettingAgreementViewCell")
            
            $0.delegate = self
            $0.dataSource = self
        }

        setUpView()
        setUpConstraint()
    }
    
    @objc func backBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - Helpers

extension SettingAgreementViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingAgreementViewCell", for: indexPath) as? SettingAgreementViewCell else{
        return UITableViewCell()
    }
    
    switch indexPath.row{
    case 0:
        cell.title.text = "개인 정보 취급방침"
        return cell
    case 1:
        cell.title.text = "서비스 이용약관"
        return cell
    case 2:
        cell.title.text = "광고성 정보 수신"
        return cell
        
    default:
        fatalError("TableViewCell Error")
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            self.navigationController?.pushViewController(PrivacyTextViewController(), animated: true)
            return
        case 1:
            self.navigationController?.pushViewController(UseServiceViewController(), animated: true)
            return
        case 2:
            self.navigationController?.pushViewController(AdTextSettingViewController(), animated: true)
            return
        default:
            return
            }
        }
    }

