//
//  ProfileModel.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/12.
//
//나중에 이름 바꿀것

import Foundation

struct ProfileGetModel : Codable, Equatable {
    
    var profileImgUrl : String?
    var nickname : String?
    var introduce : String?
    var email : String?
    
}
