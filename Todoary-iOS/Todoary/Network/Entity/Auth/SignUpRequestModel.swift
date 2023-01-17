//
//  SignUpRequestModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/17.
//

import Foundation

struct SignUpRequestModel: Codable{
    var email: String?
    var name: String?
    var nickname: String?
    var password: String?
    var isTermsEnable: Bool?
}
