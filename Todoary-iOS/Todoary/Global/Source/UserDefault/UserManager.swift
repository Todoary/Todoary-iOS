//
//  UserManager.swift
//  Todoary
//
//  Created by 박소윤 on 2023/03/03.
//

import Foundation

class UserManager {
    @UserDefault(key: UserDefaultKey.fcmToken, defaultValue: nil)
    static var fcmToken: String?
    
    @UserDefault(key: UserDefaultKey.isFirstTime, defaultValue: nil)
    static var isFirstTime: String?
    
    @UserDefault(key: UserDefaultKey.refreshToken, defaultValue: nil)
    static var refreshToken: String?
    
    @UserDefault(key: UserDefaultKey.accessToken, defaultValue: nil)
    static var accessToken: String?
    
    @UserDefault(key: UserDefaultKey.defaultImg, defaultValue: nil)
    static var defaultImg: String?
    
    @UserDefault(key: UserDefaultKey.emailCertificationCode, defaultValue: nil)
    static var emailCertificationCode: String?
    
    @UserDefault(key: UserDefaultKey.hasAppPassword, defaultValue: nil)
    static var hasAppPassword: String?
    
    @UserDefault(key: UserDefaultKey.appPassword, defaultValue: nil)
    static var appPassword: String?
}
