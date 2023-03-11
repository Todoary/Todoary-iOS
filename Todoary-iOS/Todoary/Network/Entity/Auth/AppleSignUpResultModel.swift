//
//  AppleSignUpResultModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/17.
//

import Foundation

struct AppleSignUpResultModel: Codable{
    let isNewUser: Bool
    let isDeactivatedUser: Bool
    let name: String
    let email: String
    let provider: String
    let providerId: String
    let token: Token //TODO: null로 바꿔야 할 수도
    let appleRefreshToken: String
}
