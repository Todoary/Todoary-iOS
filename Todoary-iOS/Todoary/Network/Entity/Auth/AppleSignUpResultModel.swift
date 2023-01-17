//
//  AppleSignUpResultModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/17.
//

import Foundation

struct AppleSignUpResultModel: Codable{
    let isNewUser: Bool
    let name: String
    let email: String
    let provider: String
    let providerId: String
    let token: Token
    let appleRefreshToken: String
}
