//
//  TodoCheckboxDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation
import Alamofire

class TodoCheckboxDataManager{
    
    func patch(cell: DiaryTabelViewCell, parameter: TodoCheckboxInput){
        
        AF.request("https://todoary.com/todo/check",
                   method: .patch,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   interceptor: Interceptor())
            .validate().responseDecodable(of: ApiModel.self) { response in
                switch response.result {
                case .success(let result):
                    cell.checkCheckBoxApiResultCode(code: result.code)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func patch(indexPath: IndexPath, parameter: TodoCheckboxInput){
        
        AF.request("https://todoary.com/todo/check",
                   method: .patch,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   interceptor: Interceptor())
            .validate().responseDecodable(of: ApiModel.self) { response in
                switch response.result {
                case .success(let result):
                    HomeViewController.bottomSheetVC.checkSendCheckboxApiResultCode(indexPath: indexPath, code: result.code)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
