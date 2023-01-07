//
//  CategoryMakeModel.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/29.
//

struct CategoryMakeModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result :CategoryMakeResult?
}

struct CategoryMakeResult : Decodable {
    var categoryId : Int?
}
