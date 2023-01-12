//
//  PasswordFindService.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/11.
//

import Foundation

class PasswordService: BaseService{
    static let shared = PasswordService()
    private override init() {}
}

extension PasswordService {
    
    func modifyPassword(request: PwFindInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(PasswordRouter.patchPassword(requeset: request), completion: completion)
    }
}
