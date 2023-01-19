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
    
    func getDiaryByYearMonth(yearMonth: String, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(DiaryRouter.getDiaryByYearMonth(yearMonth: yearMonth), type: [Int].self, decodingMode: .model, completion: completion)
    }
    
    func getDiarySticker(date: String, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(DiaryRouter.getDiarySticker(date: date), type: DiaryStickerResultModel.self, decodingMode: .model, completion: completion)
    }
    
    func modifyDiarySticker(date: String, request: DiaryStickerInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(DiaryRouter.putDiarySticker(date: date, request: request), type: [Int].self, decodingMode: .model, completion: completion)
    }
}
