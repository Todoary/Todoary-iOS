//
//  UserService.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation

class AlarmService: BaseService{
    static let shared = AlarmService()
    private override init() {}
}

extension AlarmService {
    
    func modifyTodoAlarmActiveStatus(request: Bool, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AlarmRouter.patchTodoAlarm(request: request), completion: completion)
    }
    
    func modifyDiaryAlarmActiveStatus(request: Bool, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AlarmRouter.patchDiaryAlarm(request: request), completion: completion)
    }
    
    func modifyRemindAlarmActiveStatus(request: Bool, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AlarmRouter.patchRemindAlarm(request: request), completion: completion)
    }
    
    func getUserAlarmActiveStatus(completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(AlarmRouter.getAlarms, type: AlarmActiveStautsModel.self, decodingMode: .model, completion: completion)
    }
}
