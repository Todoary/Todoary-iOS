//
//  TodoRouter.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation
import Alamofire

enum TodoRouter{
    case postTodo(request: TodoRequestModel)
    case patchTodo(id: Int, request: TodoRequestModel)
    case getTodoByDate(date: String)
    case getTodoByCategory(id: Int, page: Int)
    case patchCheck(id: Int, isChecked: Bool)
    case patchPin(id: Int, isPinned: Bool)
    case patchAlarm(id: Int, request: TodoAlarmRequestModel)
    case deleteTodo(id: Int)
    case getTodoByYearMonth(yearMonth: String)
}

extension TodoRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .postTodo:                                 return HTTPMethodURL.POST.todo
        case .patchTodo(let id, _):                     return HTTPMethodURL.PATCH.todo + "/\(id)"
        case .getTodoByDate(let date):                  return HTTPMethodURL.GET.todoByDate + "/\(date)"
        case .getTodoByCategory(let categoryId, _):     return HTTPMethodURL.GET.todoByCategory + "/\(categoryId)" + "/page"
        case .patchCheck:                               return HTTPMethodURL.PATCH.todoCheckbox
        case .patchPin:                                 return HTTPMethodURL.PATCH.todoPin
        case .patchAlarm(let id, _):                    return HTTPMethodURL.PATCH.todoAlarm + "/\(id)/alarm"
        case .deleteTodo(let id):                       return HTTPMethodURL.DELETE.todo + "/\(id)"
        case .getTodoByYearMonth(let yearMonth):             return HTTPMethodURL.GET.todoByYearMonth + "/\(yearMonth)"
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .postTodo:                         return .post
        case .patchTodo:                        return .patch
        case .getTodoByDate:                    return .get
        case .getTodoByCategory:                return .get
        case .patchCheck:                       return .patch
        case .patchPin:                         return .patch
        case .patchAlarm:                       return .patch
        case .deleteTodo:                       return .delete
        case .getTodoByYearMonth:               return .get
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .postTodo(let request):                return .requestBody(request)
        case .patchTodo(_, let request):            return .requestBody(request)
        case .getTodoByDate:                        return .requestPlain
        case .getTodoByCategory(_ , let page):
            let parameter: [String:Any] = ["page" : page, "size" : 1]
                                                    return .query(parameter)
        case .patchCheck(let id, let isChecked):
            let parameter: [String:Any] = ["todoId" : id, "isChecked" : isChecked]
                                                    return .requestBodyWithDictionary(parameter)
        case .patchPin(let id, let isPinned):
            let parameter: [String:Any] = ["todoId" : id, "isPinned" : isPinned]
                                                    return .requestBodyWithDictionary(parameter)
        case .patchAlarm(_, let request):           return .requestBody(request)
        case .deleteTodo:                           return .requestPlain
        case .getTodoByYearMonth:                   return .requestPlain
        }
    }
    
    var header: HeaderType{
        switch self{
        default:                    return .withToken
        }
    }
}

