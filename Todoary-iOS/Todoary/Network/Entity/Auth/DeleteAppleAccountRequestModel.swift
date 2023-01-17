//
//  DeleteAppleAccountRequestModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/17.
//

import Foundation

struct DeleteAppleAccountRequestModel: Codable{
    let email: String
    let code: String
}
