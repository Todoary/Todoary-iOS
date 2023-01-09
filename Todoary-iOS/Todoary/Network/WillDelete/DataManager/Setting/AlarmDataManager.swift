//
//  AlarmTodoDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Foundation
import Alamofire

enum AlarmType: String{
    case Todoary = "users/alarm/todo"
    case Diary = "users/alarm/diary"
    case Remind = "users/alarm/remind"
}

class AlarmDataManager {
    
    func get(viewController: AlarmSettingViewController){
        
        AF.request("https://todoary.com/users/alarm",
                   method: .get,
                   parameters: nil, interceptor: Interceptor())
            .validate().responseDecodable(of: GetAlarmCheckModel.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.code{
                    case 1000:
                        viewController.successApiResult(result.result)
                        return
                        
                    default:
                        let alert = DataBaseErrorAlert()
                        viewController.present(alert, animated: true, completion: nil)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func patch(cell: AlarmSettingTableViewCell, isChecked: Bool, alarmType: AlarmType){
        
        let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
        
        AF.request("https://todoary.com/\(alarmType.rawValue)",
                   method: .patch,
                   parameters: ["isChecked":isChecked],
                   encoder: JSONParameterEncoder.default,
                   interceptor: Interceptor())
            .validate().responseDecodable(of: ApiModel.self) { response in
                switch response.result {
                case .success(let result):
                    cell.checkAlarmApiResultCode(result.code)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
