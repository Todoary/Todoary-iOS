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
import Kingfisher

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
        let passwordFindViewController = PasswordFindViewController()
        navigationController?.pushViewController(passwordFindViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
                }
    
    @objc func logoutCellDidTab() {
        
        let alert = CancelAlertViewController(title: "로그아웃 하시겠습니까?")
        alert.alertHandler = {
            self.requestLogout()
        }
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)
        
    }


    
    @objc func accountDeleteCellDidTab() {
        
        let alert = CancelMessageAlertViewController(title: "정말 Todoary를 탈퇴하시겠습니까?", message: "탈퇴한 계정의 데이터는 1달 동안만 보관됩니다.\n그 이후에는 복구할 수 없습니다.")
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
                self.requestDeleteUser()
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
                    print("로그: [requestGetProfile] success in Account")
                    mainView.nickName.text = profileData.nickname
                    mainView.introduce.text = profileData.introduce
                    mainView.userAccount.text = profileData.email
                    if UserDefaults.standard.bool(forKey: "defaultImg") != true {
                        if (profileData.profileImgUrl != nil){
                            let url = URL(string: profileData.profileImgUrl!)
                            mainView.profileImage.kf.setImage(with: url!, placeholder:UIImage(named: "profile"))
                        }
                    }else{
                        mainView.profileImage.image = UIImage(named: "profile")
                    }
                    
                    
                }
                break
            default:
                print("로그: [requestGetProfile] fail in Account")
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    func requestDeleteUser(){
        AccountService.shared.deleteAccount{ result in
            switch result{
            case .success:
                print("LOG: SUCCESS requestDeleteUser", result)
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
                break
            default:
                print("LOG: FAIL requestDeleteUser", result)
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    func requestLogout(){
        AccountService.shared.logout(){ [self] result in
            switch result{
            case .success:
                print("로그: [requestLogout] success")
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                let loginViewController = LoginViewController()
                self.navigationController?.pushViewController(loginViewController, animated: true)
                self.navigationController?.isNavigationBarHidden = true
                break
            default:
                print("로그: [requestLogout] fail")
                DataBaseErrorAlert.show(in: self)
                break
            }
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
            requestDeleteAppleAccount(code: authorizationCode)
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
    func requestDeleteAppleAccount(code: String){
        guard let email = KeyChain.read(key: Const.UserDefaults.email) else { return }
        let parameter = DeleteAppleAccountRequestModel(email: email,
                                                       code: code)
        AccountService.shared.deleteAppleAccount(request: parameter){ result in
            switch result{
            case .success:
                self.processResponseDeleteAppleAccount()
                break
            default:
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    func processResponseDeleteAppleAccount(){
        KeyChain.delete(key: Const.UserDefaults.appleIdentifier)
        KeyChain.delete(key: Const.UserDefaults.appleRefreshToken)
        KeyChain.delete(key: Const.UserDefaults.email)
        KeyChain.delete(key: Const.UserDefaults.userName)
        
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")

        let alert = ConfirmAlertViewController(title: "계정이 삭제되었습니다.").show(in: self)
        alert.alertHandler = {
            self.navigationController?.pushViewController(LoginViewController(), animated: false)
        }
    }
    
}
