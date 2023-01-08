//
//  ProfileModel.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

struct ProfileModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result :ProfileResult?
}

struct ProfileResult : Decodable {
    var nickname : String?
    var introduce : String?
}
