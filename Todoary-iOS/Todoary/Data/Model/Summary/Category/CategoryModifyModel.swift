//
//  CategoryModifyModel.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/01.
//

struct CategoryModifyModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result :CategoryModifyResult?
}

struct CategoryModifyResult : Decodable {
    var categoryId : Int?
}
