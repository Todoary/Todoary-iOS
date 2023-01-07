//
//  AppleLoginInput.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/22.
//

import Foundation
    
struct AppleLoginInput: Encodable{
    var code: String //authorizationCode
    var idToken: String
    var name: String
    var email: String
    var isTermsEnable: Bool?
    var userIdentifier: String
}
