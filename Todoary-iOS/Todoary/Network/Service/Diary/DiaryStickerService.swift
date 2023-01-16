//
//  DiaryStickerService.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/11.
//

import Foundation

class DiaryStickerService: BaseService{
    static let shared = DiaryStickerService()
    private override init() {}
}

extension DiaryStickerService {
    
    func getDiarySticker(completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(DiaryStickerRouter.getDiarySticker, type: [DiaryStickerResultModel].self, decodingMode: .model, completion: completion)
    }
    
    func modifyDiarySticker(id: Int, request: DiaryStickerInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(DiaryStickerRouter.putDiarySticker(id: id, request: request), completion: completion)
    }
}
