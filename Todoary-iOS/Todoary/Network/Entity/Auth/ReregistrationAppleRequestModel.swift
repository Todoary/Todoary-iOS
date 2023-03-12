//
//  ReregistrationAppleRequestModel.swift
//  Todoary
//
//  Created by 박소윤 on 2023/03/11.
//

import Foundation

struct ReregistrationAppleRequestModel: Codable{
    let name: String
    let email: String
    var provider: String = "apple"
    let providerId: String
    let isTermsEnable: Bool
}
