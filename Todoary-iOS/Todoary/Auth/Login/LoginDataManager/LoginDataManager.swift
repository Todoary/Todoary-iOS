//
//  LoginDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Alamofire

class LoginDataManager{
    
    func loginDataManager(_ viewController : LoginViewController, _ parameter: LoginInput){
        AF.request("http://todoary.com:9000/auth/signin", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: LoginModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess {
                    switch result.code{
                    case 1000:
                        UserDefaults.standard.set(result.result?.token?.accessToken, forKey: "accessToken")
                        print("로그인 성공")
                        
                        let homeViewController = HomeViewController()
                        viewController.navigationController?.pushViewController(homeViewController, animated: true)
                        viewController.navigationController?.isNavigationBarHidden = true
                    default:
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