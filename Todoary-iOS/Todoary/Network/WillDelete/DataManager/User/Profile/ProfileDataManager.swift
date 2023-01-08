//
//  ProfileDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire

class ProfileDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func profileDataManager( _ viewController : ProfileViewController , _ parameter: ProfileInput) {
        AF.request("https://todoary.com/users/profile", method: .patch, parameters: parameter,  encoder: JSONParameterEncoder.default , headers: headers, interceptor: Interceptor()).validate().responseDecodable(of: ProfileModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    print("프로필수정성공")
                    viewController.mainView.nickNameNotice.isHidden = true
                    viewController.navigationController?.popViewController(animated: true)
                case 2032:
                    print("중복된 닉네임입니다")
                    viewController.mainView.nickNameNotice.isHidden = false
                default:
                    print(result.message)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
