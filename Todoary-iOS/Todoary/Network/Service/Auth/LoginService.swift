//
//  LoginService.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/11.
//

import Foundation

class LoginService: BaseService{
    static let shared = LoginService()
    private override init() {}
}

extension CategoryService {
    
   
    func login(request: LoginInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(LoginRouter.login(requeset: request), completion: completion)
    }
    
    func appleLogin(request: AppleLoginInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(LoginRouter.appleLogin(requeset: request), completion: completion)
    }
    
    func autoLogin(request: AutoLoginInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(LoginRouter.autoLogin(request: request), completion: completion)
    }
    
    func logout(request: SignoutInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(LoginRouter.logout, completion: completion)
    }
    
}
