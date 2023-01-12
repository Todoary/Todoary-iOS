//
//  TodoIndividualService.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation

class TodoIndividualService: BaseService{
    static let shared = TodoIndividualService()
    private override init() {}
}

extension TodoIndividualService {
    
    func getTodoByDate(date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        requestObject(TodoIndividualRouter.getTodoByDate(date: date), type: [TodoResultModel].self, decodingMode: .model, completion: completion)
    }
    
    func getTodoByCategory(id: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        requestObject(TodoIndividualRouter.getTodoByCategory(id: id), type: [TodoResultModel].self, decodingMode: .model, completion: completion)
    }
    
    func modifyTodoCheckStatus(id: Int, isChecked: Bool, completion: @escaping (NetworkResult<Any>) -> Void) {
        requestObjectWithEmptyResponse(TodoIndividualRouter.patchCheck(id: id, isChecked: isChecked), completion: completion)
    }
    
    func modifyTodoPinStatus(id: Int, isPinned: Bool, completion: @escaping (NetworkResult<Any>) -> Void) {
        requestObjectWithEmptyResponse(TodoIndividualRouter.patchPin(id: id, isPinned: isPinned), completion: completion)
    }
    
    func modifyTodoAlarm(id: Int, request: TodoAlarmRequestModel, completion: @escaping (NetworkResult<Any>) -> Void) {
        requestObjectWithEmptyResponse(TodoIndividualRouter.patchAlarm(id: id, request: request), completion: completion)
    }
}
