//
//  LoginResultModel.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/19.
//

struct LoginResultModel : Codable {
    var token : Token?
}

struct Token : Codable {
    var accessToken : String
    var refreshToken : String
}
