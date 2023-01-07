//
//  GetProfileModel.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

struct GetProfileModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result :GetProfileResult?
}

struct GetProfileResult : Decodable {
    var profileImgUrl : String?
    var nickname : String?
    var introduce : String?
    var email : String?
}
