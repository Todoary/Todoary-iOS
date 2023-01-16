//
//  DiaryTextRouter.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation
import Alamofire

enum DiaryTextRouter{
    case postDiary(date: String, request: DiaryRequestModel)
    case deleteDiary(date: String)
    case getDiary(date: String)
}

/*
 path
 
 POST       diary       "/diary"
 Delete     diary       "/diary"
 GET        diary       "/diary"
 */
extension DiaryTextRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .postDiary(let date, _):           return HTTPMethodURL.POST.diary + "/\(date)"
        case .deleteDiary(let date):            return HTTPMethodURL.POST.diary + "/\(date)"
        case .getDiary:                         return HTTPMethodURL.GET.diary
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .postDiary:            return .post
        case .deleteDiary:          return .delete
        case .getDiary:             return .get
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .postDiary(_, let request):    return .requestBody(request)
        case .deleteDiary:                  return .requestPlain
        case .getDiary(let date):
            let query: [String:Any] = ["createdDate" : date]
                                            return .query(query)
        }
    }
    
    var header: HeaderType{
        switch self{
        default:                    return .withToken
        }
    }
}
