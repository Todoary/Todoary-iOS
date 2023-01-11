//
//  CategoryRouter.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/07.
//

import Foundation
import Alamofire

enum CategoryRouter{
    case getCategories
    case postCategory(requeset: CategoryMakeInput)
    case patchCategory(id: Int, request: CategoryMakeInput)
    case deleteCategory(id: Int)
}


extension CategoryRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .getCategories:                        return HTTPMethodURL.GET.category
        case .postCategory:                         return HTTPMethodURL.POST.category
        case .patchCategory(let id, _):             return HTTPMethodURL.PATCH.category + "/\(id)"
        case .deleteCategory(let id):               return HTTPMethodURL.DELETE.category + "/\(id)"
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .getCategories:                        return .get
        case .postCategory:                         return .post
        case .patchCategory:                        return .patch
        case .deleteCategory:                       return .delete
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .getCategories:                        return .requestPlain
        case .postCategory(let request):            return .requestBody(request)
        case .patchCategory(_, let request):        return .requestBody(request)
        case .deleteCategory:                       return .requestPlain
        }
    }
    
    var header: HeaderType{
        switch self{
        default:    return .withToken
        }
    }
}
