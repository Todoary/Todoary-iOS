//
//  AccountRouter.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation
import Alamofire

enum AccountRouter{
    /*
     가입, 탈퇴 관리
     */
    case signUp(request: SignUpRequestModel)
    case signUpWithApple(request: AppleSignUpRequestModel)
    case deleteAccount
    case deleteAppleAccount(request: DeleteAppleAccountModel)
}

/*
 path 변경 사항 없음
 
 loginApple -> signupApple 네이밍 변경
 */
extension AccountRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .signUp:                   return HTTPMethodURL.POST.signup
        case .signUpWithApple:          return HTTPMethodURL.POST.loginApple
        case .deleteAccount:            return HTTPMethodURL.PATCH.userDelete
        case .deleteAppleAccount:       return HTTPMethodURL.POST.revokeApple
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .signUp:                   return .post
        case .signUpWithApple:          return .post
        case .deleteAccount:            return .patch
        case .deleteAppleAccount:       return .post
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .signUp(let request):                      return .requestBody(request)
        case .signUpWithApple(let request):             return .requestBody(request)
        case .deleteAccount:                            return .requestPlain
        case .deleteAppleAccount(let request):          return .requestBody(request)
        }
    }
    
    var header: HeaderType{
        switch self{
        case .deleteAccount:        return .withToken
        default:                    return .default
        }
    }
}
