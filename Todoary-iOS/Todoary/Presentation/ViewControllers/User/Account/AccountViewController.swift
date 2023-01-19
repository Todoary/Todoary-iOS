//
//  AccountViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/10.
//

import UIKit
import SnapKit
import Then
import AuthenticationServices

class AccountViewController : BaseViewController {
    
    let mainView = AccountView()
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestGetProfile()
    }
    
    override func style(){
        super.style()
        navigationTitle.text = "계정"
    }
    
    override func layout(){
        
        super.layout()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.profileChangeBtn.addTarget(self, action: #selector(profileChangeBtnDidTab), for: .touchUpInside)
        
    }
    
    //MARK: - Actions
    
    @objc func profileChangeBtnDidTab() {
        
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
                }
    
    @objc func pwFindCellDidTab() {
        let pwFindViewController = PwFindViewController()
        navigationController?.pushViewController(pwFindViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
                }
    
    @objc func logoutCellDidTab() {
        
        let alert = CancelAlertViewController(title: "로그아웃 하시겠습니까?")
        alert.alertHandler = {
            SignoutDataManager().signout(self)
        }
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)
        
    }


    
    @objc func accountDeleteCellDidTab() {
        
        let alert = CancelMessageAlertViewController(title: "정말 계정을 삭제하시겠습니까?", message: "삭제된 데이터는 복구할 수 없습니다.")
        alert.alertHandler = {
            
            if KeyChain.read(key: Const.UserDefaults.appleIdentifier) != nil{
                let appleIDProvider = ASAuthorizationAppleIDProvider()
                let request = appleIDProvider.createRequest()
                request.requestedScopes = [.fullName, .email]
                
                let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                authorizationController.delegate = self
                authorizationController.presentationContextProvider = self
                authorizationController.performRequests()
            }else{
                UserDeleteDataManager().patch(self)
            }
        }
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)

    }
    
    //MARK: - API
    
    func requestGetProfile(){
        ProfileService.shared.getProfile(){ [self] result in
            switch result{
            case .success(let data):
                if let profileData = data as? ProfileResultModel{
                    print("[requestGetProfile] success in Account")
                    mainView.nickName.text = profileData.nickname
                    mainView.introduce.text = profileData.introduce
                    mainView.userAccount.text = profileData.email
                    if (profileData.profileImgUrl != nil){
                        let url = URL(string: profileData.profileImgUrl!)
                        mainView.profileImage.load(url: url!)
                    }
                }
                break
            default:
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    func deleteApiResultCode(_ result: Int){
        switch result{
        case 1000:
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
            return
        case 2010, 4000:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        default:
            fatalError()
        }
    }
}

//MARK: - Helpers

extension AccountViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "accountTableViewCell", for: indexPath) as? AccountTableViewCell else{
            return UITableViewCell()
        }
        
        let tapPwFind = CellButtonTapGesture(target: self, action: #selector(pwFindCellDidTab))
        tapPwFind.caller = indexPath.row
        
        let tapLogout = CellButtonTapGesture(target: self, action: #selector(logoutCellDidTab))
        tapLogout.caller = indexPath.row
        
        let tapAccountDelete = CellButtonTapGesture(target: self, action: #selector(accountDeleteCellDidTab))
        tapAccountDelete.caller = indexPath.row
        
        switch indexPath.row{
        case 0:
            cell.title.text = "비밀번호 재설정"
            cell.main.addGestureRecognizer(tapPwFind)
            cell.nextBtn.addTarget(self, action: #selector(pwFindCellDidTab), for: .touchUpInside)
            return cell
        case 1:
            cell.title.text = "로그아웃"
            cell.main.addGestureRecognizer(tapLogout)
            cell.nextBtn.isHidden = true
            return cell
        case 2:
            cell.title.text = "계정 삭제하기"
            cell.title.textColor = .deleteRed
            cell.main.addGestureRecognizer(tapAccountDelete)
            cell.nextBtn.isHidden = true
            return cell
        default:
            fatalError("TableViewCell Error")
        }
    }
}

extension AccountViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate{
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    /*
     email, userName 정보 -> 키체인에 바로 저장
     userIdentifier 정보 -> 프로퍼티에 임시 저장
     이후 회원가입 완료시 userIndentifier 정보도 키체인에 저장
     
     => userIdentifier가 키체인에 있을 경우 유저 정보가 있다는 걸로..
     */
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)!
            
            UserDeleteDataManager().postAppleUserDelete(self, authorizationCode: authorizationCode)
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
}
