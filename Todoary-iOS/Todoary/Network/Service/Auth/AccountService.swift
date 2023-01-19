//
//  AccountService.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation

class AccountService: BaseService{
    static let shared = AccountService()
    private override init() {}
}

extension AccountService {
    
    func login(request: LoginInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AccountRouter.login(requeset: request), completion: completion)
    }
    
    func autoLogin(request: AutoLoginInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AccountRouter.autoLogin(request: request), completion: completion)
    }
    
    func logout(request: SignoutInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AccountRouter.logout, completion: completion)
    }
    
    func generateAccount(request: SignUpRequestModel, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AccountRouter.signUp(request: request), completion: completion)
    }
    
    func generateAppleAccount(request: AppleSignUpRequestModel, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(AccountRouter.signUpWithApple(request: request), type: AppleSignUpResultModel.self, decodingMode: .model, completion: completion)
    }
    
    func deleteAccount(completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AccountRouter.deleteAccount, completion: completion)
    }
    
    func deleteAppleAccount(request: DeleteAppleAccountRequestModel, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AccountRouter.deleteAppleAccount(request: request), completion: completion)
    }
    
    func checkUserEmailDuplicate(email: String, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AccountRouter.emailDuplicate(request: email), completion: completion)
    }
    
    func modifyPassword(request: PwFindInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AccountRouter.patchPassword(requeset: request), completion: completion)
    }
}
