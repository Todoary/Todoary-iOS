//
//  GetProfileDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire

class GetProfileDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    
    func getProfileDataManger( _ viewController : UIViewController) {
        AF.request("https://todoary.com/users", method: .get, parameters: nil, headers: headers,interceptor: Interceptor()).validate().responseDecodable(of: GetProfileModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code{
                case 1000:
                    if let vc = viewController as? ProfileViewController{
                        vc.successAPI_profile(result.result!)
                    }else if let vc = viewController as? HomeViewController{
                        vc.successAPI_home(result.result!)
                    }else if let vc = viewController as? AccountViewController{
                        vc.successAPI_account(result.result!)
                    }
                    print("프로필조회성공")
                case 2011:
                    print(result.message)
                default:
                    print(result.message)
                }
            case .failure(let error):
                if let vc = viewController as? HomeViewController{
                    vc.failureAPI_home()
                }
                print(error.localizedDescription)
            }
        }
    }
}
