//
//  ApiModel.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation

struct ApiModel: Decodable{
    var isSuccess: Bool
    var code: Int
    var messsage : String?
}
