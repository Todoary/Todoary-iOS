//
//  LoginModel.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

struct LoginModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result :LoginResult?
}

struct LoginResult : Decodable {
    var token : Token?
}

struct Token : Codable {
    var accessToken : String?
    var refreshToken : String?
}
