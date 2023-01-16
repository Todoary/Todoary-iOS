//
//  TodoRouter.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/11.
//

import Foundation
import Alamofire

enum TodoRouter{
    case postTodo(requeset: TodoSettingInput)
    case patchTodo(id: Int, request: TodoModifyInput)
}


extension TodoRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .postTodo:                         return HTTPMethodURL.POST.sticker
            //sticker 아니고 todo 따로 추가 해야함
        case .patchTodo(let id, _):             return HTTPMethodURL.PATCH.todo + "/\(id)"

        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .postTodo:                         return .post
        case .patchTodo:                        return .patch
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .postTodo(let request):            return .requestBody(request)
        case .patchTodo(_, let request):        return .requestBody(request)
        }
    }
    
    var header: HeaderType{
        switch self{
        default:    return .withToken
        }
    }
}
