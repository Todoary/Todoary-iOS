//
//  UserDeleteModel.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Foundation

struct UserDeleteModel: Decodable{
    var isSuccess: Bool
    var code: Int
    var messsage : String?
}

