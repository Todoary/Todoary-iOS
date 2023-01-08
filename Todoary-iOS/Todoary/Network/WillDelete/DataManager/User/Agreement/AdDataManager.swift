//
//  AdDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Foundation
import Alamofire

class AdDataManager{
    
    func adDataManager(viewController: AdvertiseTextSettingViewController, isChecked: Bool)
    {
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        AF.request("https://todoary.com/users/service/terms",
                method: .patch,
                parameters: ["isChecked":isChecked],
                encoder: JSONParameterEncoder.default,
                headers: headers,
                interceptor: Interceptor())
         .validate().responseDecodable(of: AdModel.self) { response in
             switch response.result {
             case .success(let result):
                 viewController.checkAdagreement(result.code)
             case .failure(let error):
                 print(error.localizedDescription)
             }
         }
    }
}
