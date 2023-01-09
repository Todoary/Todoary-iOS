//
//  TodoAlarmDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/27.
//

import Foundation
import Alamofire

class TodoAlarmDataManager{
    
    func patch(viewController: AlarmAlertViewController,todoId: Int, parameter: TodoSettingInput){
    
        AF.request("https://todoary.com/todo/\(todoId)/alarm",
                   method: .patch,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   interceptor: Interceptor())
            .validate().responseDecodable(of: ApiModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("alarm patch success")
                    viewController.successApiAlarmPatch()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
