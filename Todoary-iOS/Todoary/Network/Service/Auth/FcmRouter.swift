//
//  FcmRouter.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/20.
//

import Foundation
import Alamofire

enum FcmTokenRouter{
    case login(request: LoginRequestModel)
    case autoLogin(request: LoginRequestModel)
    case signUp(request: SignUpRequestModel)
    case signUpWithApple(request: AppleSignUpRequestModel)
    case deleteAccount
    case deleteAppleAccount(request: DeleteAppleAccountRequestModel)
    case logout
    case emailDuplicate(request: String)
    case patchPassword(requeset: PwFindInput)
}

extension AccountRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .login:                        return HTTPMethodURL.POST.login
        case .autoLogin:                    return HTTPMethodURL.POST.autoLogin
        case .signUp:                       return HTTPMethodURL.POST.signup
        case .signUpWithApple:              return HTTPMethodURL.POST.singupApple
        case .deleteAccount:                return HTTPMethodURL.PATCH.userDelete
        case .deleteAppleAccount:           return HTTPMethodURL.POST.revokeApple
        case .logout:                       return HTTPMethodURL.POST.signout
        case .emailDuplicate:               return HTTPMethodURL.GET.emailDuplicate
        case .patchPassword:                return HTTPMethodURL.PATCH.password
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .login:                        return .post
        case .autoLogin:                    return .post
        case .signUp:                       return .post
        case .signUpWithApple:              return .post
        case .deleteAccount:                return .patch
        case .deleteAppleAccount:           return .post
        case .logout:                       return .post
        case .emailDuplicate:               return .get
        case .patchPassword:                return .patch
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .signUp(let request):                      return .requestBody(request)
        case .signUpWithApple(let request):             return .requestBody(request)
        case .deleteAccount:                            return .requestPlain
        case .deleteAppleAccount(let request):          return .requestBody(request)
        case .emailDuplicate(let email):
            let parameter : [String:Any] = ["email" : email]
            return .query(parameter)
        case .login(let request):                       return .requestBody(request)
        case .autoLogin(let request):                   return .requestBody(request)
        case .logout:                                   return .requestPlain
        case .patchPassword(let request):               return .requestBody(request)
        }
    }
    
    var header: HeaderType{
        switch self{
        case .deleteAccount, .logout:        return .withToken
        default:                    return .default
        }
    }
}
