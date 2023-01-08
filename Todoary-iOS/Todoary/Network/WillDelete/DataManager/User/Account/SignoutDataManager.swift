//
//  SignoutDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire

class SignoutDataManager {
  
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        //통신
    func signout(_ viewController : UIViewController) {AF.request("https://todoary.com/users/signout", method: .post, parameters: nil, headers: headers, interceptor: Interceptor()).validate().responseDecodable(of: SignoutModel.self) {response in
            switch response.result {
            case .success(let result) :
                switch result.code {
                case 1000 :
                    UserDefaults.standard.removeObject(forKey: "accessToken")
                    UserDefaults.standard.removeObject(forKey: "refreshToken")
                    let loginViewController = LoginViewController()
                    if let vc = viewController as? AccountViewController {
                        vc.navigationController?.pushViewController(loginViewController, animated: true)
                        vc.navigationController?.isNavigationBarHidden = true
                    }else if let vc = viewController as? PwFindViewController {
                        vc.navigationController?.pushViewController(loginViewController, animated: true)
                        vc.navigationController?.isNavigationBarHidden = true
                    }
                    print("로그아웃 성공")
                
                case 4000 :
                    let alert = DataBaseErrorAlert()
                    viewController.present(alert, animated: true, completion: nil)
                default:
                    print(result.message)
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}
