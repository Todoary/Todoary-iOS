//
//  HTTPMethodURL.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/07.
//

import Foundation

enum HTTPMethodURL{
    
    struct GET {
        //AUTH
        static let emailDuplicate = "/auth/email/duplication"
        static let emailExist =  "/auth/email/existence"
        //USER
        static let profile =  "/member"
        static let alarmActivate =  "/member/alarm"
        //TODO
        static let todoByDate = "/todo/date"
        static let todoByCategory = "/todo/category"
        static let todoByYearMonth = "/todo/days"
        //CATEGORY
        static let category = "/category"
        //DIARY
        static let diary = "/diary"
        static let diaryByYearMonth = "/diary/days"
        static let sticker = "/diary"
    }
    
    struct POST {
        //AUTH
        static let login = "/auth/signin"
        static let autoLogin = "/auth/signin/auto"
        static let token = "/auth/jwt"
        static let signup = "/auth/signup"
        static let revokeApple = "/auth/revoke/apple"
        static let singupApple = "/auth/apple/token"
        //USER
        static let signout = "/member/signout"
        //TODO
        static let todo = "/todo"
        //CATEGORY
        static let category = "/category"
        //DIARY
        static let diary = "/diary"
    }
    
    struct PUT{
        static let sticker = "/diary"
    }

    struct PATCH {
        //AUTH
        static let password = "/auth/password"
        
        //USER
        static let fcmToken = "/member/fcm_token"
        static let profile = "/member/profile"
        static let imageUpdate = "/member/profile-img"
        static let imageDelete = "/member/profile-img/default"
        static let userDelete = "/member/status"
        static let todoAlarmActivate = "/member/alarm/todo"
        static let diaryAlarmActivate = "/member/alarm/diary"
        static let remindAlarmActivate = "/member/alarm/remind"
        static let marketing = "/member/service/terms"
        //TODO
        static let todo = "/todo"
        static let todoCheckbox = "/todo/check"
        static let todoPin = "/todo/pin"
        static let todoAlarm = "/todo"
        //CATEGORY
        static let category = "/category"
    }
    
    struct DELETE {
        //TODO
        static let todo = "/todo"
        //CATEGORY
        static let category = "/category"
        //DIARY
        static let diary = "/diary"
    }
    
}
