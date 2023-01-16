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
    case getDiarySticker
    case putDiarySticker(id: Int, request: DiaryStickerInput)
}

extension DiaryRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .postDiary(let date, _):           return HTTPMethodURL.POST.diary + "/\(date)"
        case .deleteDiary(let date):            return HTTPMethodURL.POST.diary + "/\(date)"
        case .getDiary:                         return HTTPMethodURL.GET.diary
        case .getDiarySticker:                        return HTTPMethodURL.GET.sticker
        case .putDiarySticker(let id, _):             return HTTPMethodURL.PUT.sticker + "/\(id)"+"/sticker"
            //url 수정 필요
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .postDiary:            return .post
        case .deleteDiary:          return .delete
        case .getDiary:             return .get
        case .getDiarySticker:                        return .get
        case .putDiarySticker:                         return .put
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .postDiary(_, let request):    return .requestBody(request)
        case .deleteDiary:                  return .requestPlain
        case .getDiary(let date):
            let query: [String:Any] = ["createdDate" : date]
                                            return .query(query)
        case .getDiarySticker:                        return .requestPlain
        case .putDiarySticker(_, let request):        return .requestBody(request)
        }
    }
    
    var header: HeaderType{
        switch self{
        default:                    return .withToken
        }
    }
}
