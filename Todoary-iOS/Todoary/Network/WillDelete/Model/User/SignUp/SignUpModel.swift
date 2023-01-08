//
//  SignUpModel.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Foundation

struct SingUpModel: Decodable{
    var isSuccess: Bool
    var code: Int
    var messsage : String?
    var result: String?
}

