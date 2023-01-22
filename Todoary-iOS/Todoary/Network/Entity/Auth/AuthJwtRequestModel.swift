//
//  AuthJwtRequestModel.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/21.
//

import Foundation

struct AuthJwtRequestModel : Codable {
    var refreshToken : String?
}
