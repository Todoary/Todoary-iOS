//
//  AskViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/10.
//

import UIKit
import MessageUI
import AVFAudio

class AskViewController: UIViewController {
    
    var navigationView: NavigationView!
    
    var tableView : UITableView!
    
    let emailHiddenButton = UIButton().then{
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        navigationView = NavigationView(frame: .zero, self.navigationController!).then{
            $0.navigationTitle.text = "문의하기"
        }
        
        tableView = UITableView().then{
            $0.delegate = self
            $0.dataSource = self
            
            $0.register(DefaultTableViewCell.self, forCellReuseIdentifier: "askSettingCell")
            
            $0.separatorStyle = .none
        }
        
        setUpView()
        setUpConstraint()
        
        menuItemInit()
    }

    override func viewWillAppear(_ animated: Bool) {
        print("???")
    }
    
    func menuItemInit(){
        
        var menuArray: [UIAction] = []
        
        let titleArray = ["버그신고","계정문의","피드백","기능추가","기타"]
        
        for i in 0...4 {
            menuArray.append(UIAction(title: titleArray[i],
                                    image: UIImage(named: "email"),
                                    handler:{ (title) in
                self.sendAskEmail(category: title.title)
                print(title.title)
            }))
        }
        
        emailHiddenButton.menu = UIMenu(title: "",
                                        options: .displayInline,
                                        children: menuArray)
        
        //long-touch 아닌 단순 터치시 띄우도록 수정
        emailHiddenButton.showsMenuAsPrimaryAction = true
    }

}

extension AskViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "askSettingCell", for: indexPath) as? DefaultTableViewCell else{
            fatalError()
        }
        
        switch indexPath.row{
        case 0:
            cell.cellTitle.text = "이메일"
            cell.backView.addSubview(emailHiddenButton)
            emailHiddenButton.snp.makeConstraints{ make in
                make.leading.trailing.top.bottom.equalToSuperview()
            }
            return cell
        case 1:
            cell.cellTitle.text = "인스타"
            return cell
        default:
            fatalError("invalid table view index")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row{
        case 1:
            
            guard let url = URL(string: "https://www.instagram.com/Todoary_official/"), UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
            //인스타그램 주소 갔다가 다시 돌아왔을 때 클릭(select) 표시 제거
            tableView.deselectRow(at: indexPath, animated: true)
            return
        default:
            return
        }
    }
    
}

extension AskViewController: MFMailComposeViewControllerDelegate{
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendAskEmail(category: String){
        
        if !MFMailComposeViewController.canSendMail(){
            print("Mail services are not available")
            showSendMailErrorAlert()
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        composeVC.setToRecipients(["feedback@todoary.com"])
        composeVC.setSubject(category)
        composeVC.setMessageBody("BODY", isHTML: false)
        
        self.present(composeVC, animated: true, completion: nil)
        
    }
    
    func showSendMailErrorAlert(){
        let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "기기 내 메일 앱 설정을 확인해주세요.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        sendMailErrorAlert.addAction(confirmAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
}
