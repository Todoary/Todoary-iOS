//
//  FcmRouter.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/20.
//

import Foundation
import Alamofire

enum FcmTokenRouter{
    case patchFcmToken(request: FcmTokenRequestModel)
}

extension FcmTokenRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .patchFcmToken:                        return HTTPMethodURL.PATCH.fcmToken
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .patchFcmToken:                        return .patch
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .patchFcmToken(let request):           return .requestBody(request)
        }
    }
    
    var header: HeaderType{
        switch self{
        default:                    return .withToken
        }
    }
}
