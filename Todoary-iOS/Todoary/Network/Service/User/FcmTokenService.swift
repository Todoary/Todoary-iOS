//
//  FcmService.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/20.
//

import Foundation
class FcmTokenService: BaseService{
    static let shared = FcmTokenService()
    private override init() {}
}

extension FcmTokenService {
    
    func modifyFcmToken(request: FcmTokenRequestModel, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(FcmTokenRouter.patchFcmToken(request: request), completion: completion)
    }
}
