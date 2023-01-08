//
//  GetDiaryExistenceModel.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/23.
//

struct GetDiaryExistenceModel: Decodable{
    var isSuccess: Bool
    var code: Int
    var message : String
    var result : [Int]
}
