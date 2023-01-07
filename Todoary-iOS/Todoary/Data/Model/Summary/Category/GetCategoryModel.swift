//
//  GetCategoryModel.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/31.
//
struct GetCategoryModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result :[GetCategoryResult]
}

struct GetCategoryResult : Decodable, Equatable {
    var id : Int
    var title : String
    var color : Int
    
    static func ==(lhs: GetCategoryResult, rhs: GetCategoryResult) -> Bool {
        return lhs.id == rhs.id
    }
}
