//
//  ProfileRouter.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/11.
//

import Foundation
import Alamofire

enum ProfileRouter{
    case getProfile
    case patchProfile(requeset: ProfileInput)
    case patchProfileImage(request: ProfileImgInput)
    case deleteProfileImage
}


extension ProfileRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .getProfile:                           return HTTPMethodURL.GET.profile
        case .patchProfile:                         return HTTPMethodURL.PATCH.profile
        case .patchProfileImage:                    return HTTPMethodURL.PATCH.imageUpdate
        case .deleteProfileImage:                   return HTTPMethodURL.PATCH.imageDelete
            //이미지 delete patch 아니고 delete임!!!!
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .getProfile:                           return .get
        case .patchProfile:                         return .patch
        case .patchProfileImage:                    return .patch
        case .deleteProfileImage:                   return .delete
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .getProfile:                           return .requestPlain
        case .patchProfile(let request):            return .requestBody(request)
        case .patchProfileImage(let request):       return .requestBody(request as! Encodable)
        case .deleteProfileImage:                   return .requestPlain
        }
    }
    
    var header: HeaderType{
        switch self{
        case .patchProfileImage:                    return .multiPartWithToken
        default:                                    return .withToken
        }
    }
}

