//
//  RestoreRequestModel.swift
//  Todoary
//
//  Created by 박소윤 on 2023/03/11.
//

import Foundation

struct RestoreRequestModel: Codable{
    let email: String
    let provider: String?
    let providerId: String
}
