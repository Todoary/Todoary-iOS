//
//  FcmTokenModel.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/22.
//

struct FcmTokenModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : String
}
