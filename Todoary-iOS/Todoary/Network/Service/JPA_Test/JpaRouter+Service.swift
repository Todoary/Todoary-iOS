//
//  JpaRouter.swift
//  Todoary
//
//  Created by 박소윤 on 2023/02/20.
//

import Foundation
import Alamofire

enum JpaRouter{
    case getTodoByCategory(id: Int, page: Int)
}

extension JpaRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .getTodoByCategory(let categoryId, _):
            return HTTPMethodURL.GET.todoByCategory + "/\(categoryId)" + "/page"
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .getTodoByCategory:                return .get
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .getTodoByCategory(_ , let page):
            let parameter: [String:Any] = ["page" : page, "size" : 1]
                                                    return .query(parameter)
        }
    }
    
    var baseURL: String{
        return "https://dev.todoary.com"
    }
    
    var header: HeaderType{
        switch self{
        default:                    return .withToken
        }
    }
}

