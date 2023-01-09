//
//  UserDeleteDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Foundation
import Alamofire

class UserDeleteDataManager{

    func patch(_ viewController: AccountViewController){
        
        AF.request("https://todoary.com/users/status", method: .patch, parameters: [:], interceptor: Interceptor()).validate().responseDecodable(of: UserDeleteModel.self) { response in
            switch response.result {
            case .success(let result):
                print("계정삭제성공")
                viewController.deleteApiResultCode(result.code)
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                return
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func postAppleUserDelete(_ viewController: AccountViewController, authorizationCode: String){
        
        guard let email = KeyChain.read(key: Const.UserDefaults.email) else { return }
        
        AF.request("https://todoary.com/auth/revoke/apple", method: .post, parameters: ["code":authorizationCode, "email": email], encoder: JSONParameterEncoder.default).validate().responseDecodable(of: ApiModel.self) { response in
            
            switch response.result {
            case .success(let result):
                switch result.code{
                case 1000:
                    print("성공")
                    
                    KeyChain.delete(key: Const.UserDefaults.appleIdentifier)
                    KeyChain.delete(key: Const.UserDefaults.appleRefreshToken)
                    KeyChain.delete(key: Const.UserDefaults.email)
                    KeyChain.delete(key: Const.UserDefaults.userName)
                    
                    UserDefaults.standard.removeObject(forKey: "accessToken")
                    UserDefaults.standard.removeObject(forKey: "refreshToken")
    
                    let alert = ConfirmAlertViewController(title: "계정이 삭제되었습니다.")
                    alert.alertHandler = {
                        viewController.navigationController?.pushViewController(LoginViewController(), animated: false)
                    }
                    alert.modalPresentationStyle = .overFullScreen
                    viewController.present(alert, animated: false, completion: nil)
                
                default:
                    print(result.code)
                    
                    let alert = DataBaseErrorAlert()
                    viewController.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
