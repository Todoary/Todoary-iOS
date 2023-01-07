//
//  ProfileImgModel.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Foundation

struct ProfileImgModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : ProfileImgModelResult?
    
}

//struct ProfileImgModelResult : Decodable {
//    var user_id : Int
//    var profile_img_url : String
//}

struct ProfileImgModelResult : Codable {
    
    var userId : Int
    var profileImageUrl : String
    
    enum CodingKeys: String,CodingKey{
        case userId = "user_id"
        case profileImageUrl = "profile_img_url"
    }

}
