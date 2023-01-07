//
//  TodoPinDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/30.
//

import UIKit
import Alamofire

class TodoPinDataManager {

    func patch(parameter: TodoPinInput, indexPath: IndexPath){
        
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        AF.request("https://todoary.com/todo/pin",
                   method: .patch,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: headers,
                   interceptor: Interceptor())
            .validate().responseDecodable(of: ApiModel.self) { response in
                switch response.result {
                case .success(let result):
                    HomeViewController.bottomSheetVC.checkSendPinApiResultCode(result.code, indexPath)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
