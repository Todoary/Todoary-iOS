//
//  FcmTokendataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/22.
//

import Alamofire

class FcmTokendataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func fcmTokendataManager( _ viewController : HomeViewController , _ parameter: FcmTokenInput) {
        AF.request("https://todoary.com/users/fcm_token", method: .patch, parameters: parameter,  encoder: JSONParameterEncoder.default , headers: headers, interceptor: Interceptor()).validate().responseDecodable(of: FcmTokenModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    print("fcm 수정성공")
                case 4015:
                    print("fcm 수정실패")
                default:
                    print(result.message)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
