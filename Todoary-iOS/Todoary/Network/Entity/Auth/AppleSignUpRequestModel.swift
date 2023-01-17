//
//  AppleSignUpRequestModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/17.
//

import Foundation

struct AppleSignUpRequestModel: Codable{
    let code: String //authorizationCode
    let idToken: String
    let name: String
    let email: String
    let isTermsEnable: Bool
    let userIdentifier: String
}
