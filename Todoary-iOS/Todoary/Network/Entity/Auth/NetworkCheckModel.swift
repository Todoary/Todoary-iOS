//
//  NetworkCheckModel.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/21.
//

import Foundation

struct NetworkCheckModel: Decodable{
    var isSuccess: Bool
    var code: Int
    var messsage : String?
    var result: String?
}
