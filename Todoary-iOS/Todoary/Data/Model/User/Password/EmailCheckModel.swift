//
//  EmailCheckModel.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/24.
//

struct EmailCheckModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result :String?
}
