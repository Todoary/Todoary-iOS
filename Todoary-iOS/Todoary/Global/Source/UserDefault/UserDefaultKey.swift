//
//  UserDefaultKey.swift
//  Todoary
//
//  Created by 박소윤 on 2023/03/03.
//

import Foundation

enum UserDefaultKey: String{
    case fcmToken = "fcmToken"
    case isFirstTime = "isFirstTime"
    case accessToken = "accessToken"
    case refreshToken = "refreshToken"
    case defaultImg = "defaultImg"
    case emailCertificationCode = "emailCertificationCode" //기존 key 네이밍
    case hasAppPassword = "hasAppPassword"
    case appPassword = "appPassword" //기존 newPasswordArr
}

