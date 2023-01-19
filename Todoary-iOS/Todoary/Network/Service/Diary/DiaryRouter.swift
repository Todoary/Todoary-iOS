//
//  DiaryRouter.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation
import Alamofire

enum DiaryRouter{
    case postDiary(date: String, request: DiaryRequestModel)
    case deleteDiary(date: String)
    case getDiary(date: String)
    case getDiarySticker(date: String)
    case putDiarySticker(date: String, request: DiaryStickerInput)
}

extension DiaryRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .postDiary(let date, _):           return HTTPMethodURL.POST.diary + "/\(date)"
        case .deleteDiary(let date):            return HTTPMethodURL.POST.diary + "/\(date)"
        case .getDiary:                         return HTTPMethodURL.GET.diary
        case .getDiarySticker(let date):        return HTTPMethodURL.GET.sticker + "/\(date)/sticker"
        case .putDiarySticker(let date, _):     return HTTPMethodURL.PUT.sticker + "/\(date)/sticker"
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .postDiary:            return .post
        case .deleteDiary:          return .delete
        case .getDiary:             return .get
        case .getDiarySticker:      return .get
        case .putDiarySticker:      return .put
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .postDiary(_, let request):    return .requestBody(request)
        case .deleteDiary:                  return .requestPlain
        case .getDiary(let date):
            let query: [String:Any] = ["createdDate" : date]
                                            return .query(query)
        case .getDiarySticker(let date):
            let query: [String:Any] = ["createdDate" : date]
                                            return .query(query)
        case .putDiarySticker(_, let request):        return .requestBody(request)
        }
    }
    
    var header: HeaderType{
        switch self{
        default:                    return .withToken
        }
    }
}
