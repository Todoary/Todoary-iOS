//
//  SignUpInput.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Foundation

struct SignUpInput: Encodable{
    
    var email: String?
    var name: String?
    var nickname: String?
    var password: String?
    var isTermsEnable: Bool?
    
    //email 유효성 검사용 생성자
    init(email: String) {
        self.email = email
    }
    
    //회원가입용 생성자
    init(email: String, name: String, nickname: String, password: String, isTermsEnable: Bool) {
        self.email = email
        self.name = name
        self.nickname = nickname
        self.password = password
        self.isTermsEnable = isTermsEnable
    }
    
}
