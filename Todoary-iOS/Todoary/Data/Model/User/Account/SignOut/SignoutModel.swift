//
//  SignoutModel.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

struct SignoutModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
}
