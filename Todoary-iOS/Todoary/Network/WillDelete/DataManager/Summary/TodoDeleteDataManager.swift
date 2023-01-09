//
//  TodoDeleteDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation
import Alamofire

class TodoDeleteDataManager{
    
    func delete(viewController: CategoryViewController, todoId: Int, indexPath: IndexPath){
        
        AF.request("https://todoary.com/todo/\(todoId)",
                   method: .delete,
                   parameters: [:],
                   interceptor: Interceptor())
            .validate()
            .responseDecodable(of: UserDeleteModel.self) { response in
                switch response.result {
                case .success(let result):
                    viewController.checkDeleteApiResultCode(code: result.code, indexPath: indexPath)
                    return
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }

    func delete(todoId: Int, indexPath: IndexPath){
    
        AF.request("https://todoary.com/todo/\(todoId)",
                   method: .delete,
                   parameters: [:],
                   interceptor: Interceptor())
            .validate()
            .responseDecodable(of: UserDeleteModel.self) { response in
                switch response.result {
                case .success(let result):
                    HomeViewController.bottomSheetVC.checkTodoDeleteApiResultCode(result.code, indexPath)
                    return
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}
