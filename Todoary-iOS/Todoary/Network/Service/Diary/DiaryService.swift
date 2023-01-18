//
//  DiaryService.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation

class DiaryService: BaseService{
    static let shared = DiaryService()
    private override init() {}
}

extension DiaryService {
    
    func generateDiary(date: String, request: DiaryRequestModel,completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(DiaryRouter.postDiary(date: date, request: request), completion: completion)
    }
    
    func deleteDiary(date: String, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(DiaryRouter.deleteDiary(date: date), completion: completion)
    }
    
    func getDiary(date: String, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(DiaryRouter.getDiary(date: date), type: DiaryResultModel.self, decodingMode: .model, completion: completion)
    }
    
    func getDiarySticker(completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(DiaryRouter.getDiarySticker, type: [DiaryStickerResultModel].self, decodingMode: .model, completion: completion)
    }
    
    func modifyDiarySticker(id: Int, request: DiaryStickerInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(DiaryRouter.putDiarySticker(id: id, request: request), type: [Int].self, decodingMode: .model, completion: completion)
    }
}
