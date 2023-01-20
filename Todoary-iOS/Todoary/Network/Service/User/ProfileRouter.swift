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
    case patchProfile(requeset: ProfileRequestModel)
    case patchProfileImage(image: UIImage)
    case deleteProfileImage
}


extension ProfileRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .getProfile:                           return HTTPMethodURL.GET.profile
        case .patchProfile:                         return HTTPMethodURL.PATCH.profile
        case .patchProfileImage:                    return HTTPMethodURL.PATCH.imageUpdate
        case .deleteProfileImage:                   return HTTPMethodURL.PATCH.imageDelete
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .getProfile:                           return .get
        case .patchProfile:                         return .patch
        case .patchProfileImage:                    return .patch
        case .deleteProfileImage:                   return .patch
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .getProfile:                           return .requestPlain
        case .patchProfile(let request):            return .requestBody(request)
        case .patchProfileImage:                    return .requestPlain
        case .deleteProfileImage:                   return .requestPlain
        }
    }
    
    var header: HeaderType{
        switch self{
        case .patchProfileImage:                    return .multiPartWithToken
        default:                                    return .withToken
        }
    }
    
    var multipart: MultipartFormData {
        switch self {
        case .patchProfileImage(let image):
            let multiPart = MultipartFormData()

            if let image = image.jpegData(compressionQuality: 0.1) {
                multiPart.append(image, withName: "profile-img", fileName: "\(image).jpeg", mimeType: "image/ipeg")
            }

            return multiPart
        
        default: return MultipartFormData()
        }
    }
}
