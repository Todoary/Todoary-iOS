//
//  TodoIndividualRouter.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation
import Alamofire

enum TodoIndividualRouter{
    case getTodoByDate(date: String)
    case getTodoByCategory(id: Int)
    case patchCheck(id: Int, isChecked: Bool)
    case patchPin(id: Int, isPinned: Bool)
    case patchAlarm(id: Int, request: TodoAlarmRequestModel)
}

/*
 path 변경 사항
 
 GET.           todoByDate          "/todo/date"
 GET.           todoByCategory      "/todo/category"
 PATCH.         todoAlarm           "/todo"
 
 */
extension TodoIndividualRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .getTodoByDate(let date):                  return HTTPMethodURL.GET.todoByDate + "/\(date)"
        case .getTodoByCategory(let categoryId):        return HTTPMethodURL.GET.todoByCategory + "/\(categoryId)"
        case .patchCheck:                               return HTTPMethodURL.PATCH.todoCheckbox
        case .patchPin:                                 return HTTPMethodURL.PATCH.todoPin
        case .patchAlarm(let id, _):                    return HTTPMethodURL.PATCH.todoAlarm + "/\(id)/alarm"
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .getTodoByDate:             return .get
        case .getTodoByCategory:         return .get
        case .patchCheck:                return .patch
        case .patchPin:                  return .patch
        case .patchAlarm:                return .patch
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .getTodoByDate:                        return .requestPlain
        case .getTodoByCategory:                    return .requestPlain
        case .patchCheck(let id, let isChecked):
            let parameter: [String:Any] = ["todoId" : id, "isChecked" : isChecked]
                                                    return .requestBodyWithDictionary(parameter)
        case .patchPin(let id, let isPinned):
            let parameter: [String:Any] = ["todoId" : id, "isPinned" : isPinned]
                                                    return .requestBodyWithDictionary(parameter)
        case .patchAlarm(_, let request):           return .requestBody(request)
        }
    }
    
    var header: HeaderType{
        switch self{
        default:                    return .withToken
        }
    }
}

