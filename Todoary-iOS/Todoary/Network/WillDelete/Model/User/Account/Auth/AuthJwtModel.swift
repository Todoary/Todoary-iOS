//
//  AuthJwtModel.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/26.
//

struct AuthJwtModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result :AuthJwtResult?
}

struct AuthJwtResult : Decodable {
    var token : Token?
}
