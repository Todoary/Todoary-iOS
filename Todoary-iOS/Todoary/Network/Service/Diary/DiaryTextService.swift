//
//  DiaryTextService.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation

class DiaryTextService: BaseService{
    static let shared = DiaryTextService()
    private override init() {}
}

extension DiaryTextService {
    
    func generateDiary(date: String, request: DiaryRequestModel,completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(DiaryTextRouter.postDiary(date: date, request: request), completion: completion)
    }
    
    func deleteDiary(date: String, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(DiaryTextRouter.deleteDiary(date: date), completion: completion)
    }
    
    func getDiary(date: String, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(DiaryTextRouter.getDiary(date: date), type: DiaryResultModel.self, decodingMode: .model, completion: completion)
    }
}
