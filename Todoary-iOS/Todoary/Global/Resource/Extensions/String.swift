//
//  String.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/02.
//

import Foundation

//정규 표현식
extension String{
    
    //영문, 숫자 포함 8자리 이상
    func isValidPassword() -> Bool{
        let regularExpression = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: self)
    }
    
    //아직 제약 없나?
    func isValidEmail() -> Bool{
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    //1자 이상, 10자 이하
    func isValidName() -> Bool{
        let nameRegEx = "^[가-힣A-Za-z]{1,8}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    
    //1자 이상, 8자 이하
    func isValidNickname() -> Bool{
        let nicknameRegEx = "^[가-힣A-Za-z0-9]{1,10}"
        let nicknameTest = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
        return nicknameTest.evaluate(with: self)
    }
}
