//
//  TodoGetByCategoryDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation
import Alamofire

class TodoGetByCategoryDataManager{
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func get(viewController: CategoryViewController, categoryId: Int){
        
        AF.request("https://todoary.com/todo/category/\(categoryId)",
                   method: .get,
                   parameters: nil,
                   headers: headers,
                   interceptor: Interceptor())
            .validate().responseDecodable(of: GetTodoModel.self) { response in
                switch response.result {
                case .success(let result):
                    viewController.checkGetTodoApiResultCode(result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func get(indexPath: IndexPath, viewController: CategoryViewController, categoryId: Int){
        
        AF.request("https://todoary.com/todo/category/\(categoryId)",
                   method: .get,
                   parameters: nil,
                   headers: headers)
            .validate().responseDecodable(of: GetTodoModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("성공")
                    viewController.checkGetTodoApiResultCode(indexPath, result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
