//
//  FcmTokendataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/22.
//

import Alamofire

class FcmTokendataManager {
    
    func fcmTokendataManager(_ parameter: FcmTokenInput) {
        AF.request("https://todoary.com/users/fcm_token", method: .patch, parameters: parameter,  encoder: JSONParameterEncoder.default , interceptor: Interceptor()).validate().responseDecodable(of: FcmTokenModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    print("fcm 수정성공")
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.successAPI()
                case 4015:
                    print("fcm 수정실패")
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.backToLoginViewController()
                default:
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.backToLoginViewController()
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
