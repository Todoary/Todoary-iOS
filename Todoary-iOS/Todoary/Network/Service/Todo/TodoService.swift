//
//  TodoService.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation

class TodoService: BaseService{
    static let shared = TodoService()
    private override init() {}
}

extension TodoService {
    
    func generateTodo(request: TodoRequestModel, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(TodoRouter.postTodo(request: request), completion: completion)
    }
    
    func modifyTodo(id: Int, request: TodoRequestModel, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(TodoRouter.patchTodo(id: id, request: request), completion: completion)
    }
    
    func getTodoByDate(date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        requestObject(TodoRouter.getTodoByDate(date: date), type: [TodoResultModel].self, decodingMode: .model, completion: completion)
    }
    
    func getTodoByCategory(id: Int, page: Int, completion: @escaping (NetworkResult<Any>) -> Void) { //PageableResponseModel [TodoResultModel]
        requestObject(TodoRouter.getTodoByCategory(id: id, page: page), type: PageableResponseModel.self, decodingMode: .model, completion: completion)
    }
    
    func modifyTodoCheckStatus(id: Int, isChecked: Bool, completion: @escaping (NetworkResult<Any>) -> Void) {
        requestObjectWithEmptyResponse(TodoRouter.patchCheck(id: id, isChecked: isChecked), completion: completion)
    }
    
    func modifyTodoPinStatus(id: Int, isPinned: Bool, completion: @escaping (NetworkResult<Any>) -> Void) {
        requestObjectWithEmptyResponse(TodoRouter.patchPin(id: id, isPinned: isPinned), completion: completion)
    }
    
    func modifyTodoAlarm(id: Int, request: TodoAlarmRequestModel, completion: @escaping (NetworkResult<Any>) -> Void) {
        requestObjectWithEmptyResponse(TodoRouter.patchAlarm(id: id, request: request), completion: completion)
    }
    
    func deleteTodo(id: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        requestObjectWithEmptyResponse(TodoRouter.deleteTodo(id: id), completion: completion)
    }
    
    func getTodoByYearMonth(yearMonth: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        requestObject(TodoRouter.getTodoByYearMonth(yearMonth: yearMonth), type: [Int].self, decodingMode: .model, completion: completion)
    }
}
