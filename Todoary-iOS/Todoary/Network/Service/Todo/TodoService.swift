//
//  TodoService.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/11.
//

import Foundation

class TodoService: BaseService{
    static let shared = TodoService()
    private override init() {}
}

extension TodoService {
    
    func generateTodo(request: TodoSettingInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(TodoRouter.postTodo(requeset: request), completion: completion)
    }
    
    func modifyTodo(id: Int, request: TodoModifyInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(TodoRouter.patchTodo(id: id, request: request), completion: completion)
    }
}
