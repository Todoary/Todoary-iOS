//
//  LoginRouter.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/11.
//

import Foundation
import Alamofire

enum LoginRouter{
    case login(requeset: LoginInput)
    case appleLogin(requeset: AppleLoginInput)
    case autoLogin(request: AutoLoginInput)
    case logout
}


extension LoginRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .login:                        return HTTPMethodURL.POST.login
        case .appleLogin:                   return HTTPMethodURL.POST.loginApple
        case .autoLogin:                    return HTTPMethodURL.POST.autoLogin
        case .logout:                       return HTTPMethodURL.POST.signout
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .login:                        return .post
        case .appleLogin:                   return .post
        case .autoLogin:                    return .post
        case .logout:                       return .post
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .login:                        return .requestPlain
        case .appleLogin(let request):      return .requestBody(request)
        case .autoLogin(let request):       return .requestBody(request)
        case .logout:                       return .requestPlain
        }
    }
    
    var header: HeaderType{
        switch self{
        case .logout:   return .withToken
        default:    return .default
        }
    }
}
