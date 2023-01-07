//
//  AppleLoginModel.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/22.
//

import Foundation

struct AppleLoginModel: Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result: AppleLoginResult?
}


struct AppleLoginResult: Decodable{
    var isNewUser: Bool?
    var name: String?
    var email: String?
    var provider: String?
    var providerId: String?
    var token: Token?
    var appleRefreshToken: String?
}
