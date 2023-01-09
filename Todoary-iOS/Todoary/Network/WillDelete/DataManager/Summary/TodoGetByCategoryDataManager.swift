//
//  TodoGetByCategoryDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation
import Alamofire

class TodoGetByCategoryDataManager{
    
    func get(viewController: CategoryViewController, categoryId: Int){
        
        AF.request("https://todoary.com/todo/category/\(categoryId)",
                   method: .get,
                   parameters: nil,
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
                   interceptor: Interceptor())
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
