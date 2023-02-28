//
//  NetworkCheck.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/21.
//

import Foundation
import Alamofire

class NetworkCheck{
    
    func networkCheck(){
        let fcmToken = FcmTokenRequestModel(fcmToken: "networkCheck")
        
        AF.request("https://\(Bundle.main.infoDictionary?["API-BASE-URL"] as? String ?? "")/member/fcm_token", method: .patch, parameters: fcmToken,  encoder: JSONParameterEncoder.default , interceptor: Interceptor()).validate().responseDecodable(of: NetworkCheckModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    print("네트워크체크성공")
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.successAPI()
                default:
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.backToLoginViewController()
                }
            case .failure(let error):
                print(error.localizedDescription)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.backToLoginViewController()
            }
        }
    }
}
