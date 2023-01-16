//
//  WithdrawalModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation

struct SignUpRequestModel: Codable{
    var email: String?
    var name: String?
    var nickname: String?
    var password: String?
    var isTermsEnable: Bool?
}

struct AppleSignUpRequestModel: Codable{
    let code: String //authorizationCode
    let idToken: String
    let name: String
    let email: String
    let isTermsEnable: Bool
    let userIdentifier: String
}

// Token 구조체 Codable 선언 이후 아래 주석 풀기
struct AppleSignUpResultModel: Codable{
    let isNewUser: Bool
    let name: String
    let email: String
    let provider: String
    let providerId: String
//    let token: Token
    let appleRefreshToken: String
}


struct DeleteAppleAccountRequestModel: Codable{
    let email: String
    let code: String
}
