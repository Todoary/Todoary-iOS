//
//  MarketingService.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/16.
//

import Foundation

class MarketingService: BaseService{
    static let shared = MarketingService()
    private override init() {}
}

extension MarketingService {
    
    func modifyMarketingAgreementStatus(request: Bool, completion: @escaping (NetworkResult<Any>) -> Void){
//        requestObjectWithEmptyResponse(MarketingRouter.patchAgreement(request: request), completion: completion)
    }
}
