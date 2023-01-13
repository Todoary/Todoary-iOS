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
    
    func generateAccount(request: SignUpRequestModel, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AccountRouter.signUp(request: request), completion: completion)
    }
    
    func generateAppleAccount(request: AppleSignUpRequestModel, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(AccountRouter.signUpWithApple(request: request), type: AppleSignUPResultModel.self, decodingMode: .model, completion: completion)
    }
    
    func deleteAccount(completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AccountRouter.deleteAccount, completion: completion)
    }
    
    func deleteAppleAccount(request: DeleteAppleAccountModel, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AccountRouter.deleteAppleAccount(request: request), completion: completion)
    }
    
    func getIsUserEmailDuplicate(email: String, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(AccountRouter.emailDuplicate(email: email), completion: completion)
    }
}
