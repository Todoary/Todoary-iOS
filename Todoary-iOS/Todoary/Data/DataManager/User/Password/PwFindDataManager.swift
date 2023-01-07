//
//  SignUpDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Foundation
import Alamofire

class PwFindDataManager{
    
    func pwFindDataManager(_ viewController: PwFindViewController, _ parameter: PwFindInput){
        
        AF.request("https://todoary.com/auth/password", method: .patch, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil, interceptor: Interceptor()).validate().responseDecodable(of: PwFindModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code{
                case 1000:
                    if (UserDefaults.standard.string(forKey: "accessToken") != nil) {
                        SignoutDataManager().signout(viewController)
                    }else {
                        let loginViewController = LoginViewController()
                        viewController.navigationController?.pushViewController(loginViewController, animated: true)
                        viewController.navigationController?.isNavigationBarHidden = true
                    }
                    print("비밀번호재설정성공")
                case 2011:
                    print(result.message)
                default:
                    let alert = DataBaseErrorAlert()
                    viewController.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
