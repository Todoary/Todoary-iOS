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
        
        AF.request("http://todoary.com:9000/auth/password", method: .patch, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: PwFindModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess {
                    if result.code == 1000{
                        if (UserDefaults.standard.string(forKey: "accessToken") != nil) {
                            SignoutDataManager().signout(viewController)
                        }else {
                            let loginViewController = LoginViewController()
                            viewController.navigationController?.pushViewController(loginViewController, animated: true)
                            viewController.navigationController?.isNavigationBarHidden = true
                        }
                        print("비밀번호재설정성공")
                    }else{
                        print(result.message)
                    }
                }else {
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}