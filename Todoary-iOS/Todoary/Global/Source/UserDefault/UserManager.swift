//
//  UserManager.swift
//  Todoary
//
//  Created by 박소윤 on 2023/03/03.
//

import Foundation

class UserManager {
    @UserDefault(key: UserDefaultKey.fcmToken.rawValue, defaultValue: nil)
    static var fcmToken: String?
    
    @UserDefault(key: UserDefaultKey.isFirstTime.rawValue, defaultValue: true)
    static var isFirstTime: Bool
    
    @UserDefault(key: UserDefaultKey.refreshToken.rawValue, defaultValue: nil)
    static var refreshToken: String?
    
    @UserDefault(key: UserDefaultKey.accessToken.rawValue, defaultValue: nil)
    static var accessToken: String?
    
    @UserDefault(key: UserDefaultKey.defaultImg.rawValue, defaultValue: true)
    static var defaultImg: Bool
    
    @UserDefault(key: UserDefaultKey.emailCertificationCode.rawValue, defaultValue: nil)
    static var emailCertificationCode: String?
    
    @UserDefault(key: UserDefaultKey.hasAppPassword.rawValue, defaultValue: false)
    static var hasAppPassword: Bool
    
    @UserDefault(key: UserDefaultKey.appPassword.rawValue, defaultValue: nil)
    static var appPassword: [String]?
    
    static func removeObject(key: UserDefaultKey){
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
