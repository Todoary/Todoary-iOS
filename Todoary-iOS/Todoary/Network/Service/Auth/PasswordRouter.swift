//
//  PasswordFindRouter.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/11.
//

import Foundation

import Alamofire

enum PasswordRouter{
    case patchPassword(requeset: PwFindInput)
}


extension PasswordRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .patchPassword:                 return HTTPMethodURL.PATCH.password
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .patchPassword:                 return .patch
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .patchPassword(let request):    return .requestBody(request)
        }
    }
    
    var header: HeaderType{
        switch self{
        default:                             return .default
        }
    }
}
