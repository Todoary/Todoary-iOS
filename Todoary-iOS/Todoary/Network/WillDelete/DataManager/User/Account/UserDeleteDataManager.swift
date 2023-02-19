//
//  UserDeleteDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Foundation
import Alamofire

struct UserDeleteModel: Decodable{
    var isSuccess: Bool
    var code: Int
    var messsage : String?
}

class UserDeleteDataManager{

    func patch(_ viewController: AccountViewController){
        
        AF.request("https://todoary.com/users/status", method: .patch, parameters: [:], interceptor: Interceptor()).validate().responseDecodable(of: UserDeleteModel.self) { response in
            switch response.result {
            case .success(let result):
                print("계정삭제성공")
                viewController.deleteApiResultCode(result.code)
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                return
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
