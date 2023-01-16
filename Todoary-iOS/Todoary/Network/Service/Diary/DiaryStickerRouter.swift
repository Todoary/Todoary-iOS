//
//  DiaryStickerRouter.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/11.
//

import Foundation
import Alamofire

enum DiaryStickerRouter{
    case getDiarySticker
    case putDiarySticker(id: Int, request: DiaryStickerInput)
}


extension DiaryStickerRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .getDiarySticker:                        return HTTPMethodURL.GET.sticker
        case .putDiarySticker(let id, _):             return HTTPMethodURL.PUT.sticker + "/\(id)"+"/sticker"
            //url 수정 필요
            
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .getDiarySticker:                        return .get
        case .putDiarySticker:                         return .put
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .getDiarySticker:                        return .requestPlain
        case .putDiarySticker(_, let request):        return .requestBody(request)
        }
    }
    
    var header: HeaderType{
        switch self{
        default:    return .withToken
        }
    }
}
