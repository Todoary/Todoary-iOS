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
        static let emailDuplicate = "/auth/email/duplication?email="
        static let emailExist =  "/auth/email/existence?email="
        //USER
        static let profile =  "/users"
        static let alarmActivate =  "/users/alarm"
        //TODO
        static let todoByDate = "/todo/date/:date"
        static let todoByCategory = "/todo/category/:categoryId"
        static let todoByYearMonth = "/todo/days/:year-month"
        //CATEGORY
        static let category = "/category"
        //DIARY
        static let diary = "/diary?createdDate="
        static let diaryByYearMonth = "/diary/days/:year-month"
        static let sticker = "/diary/:createdDate/sticker"
    }
    
    struct POST {
        //AUTH
        static let login = "/auth/signin"
        static let autoLogin = "/auth/signin/auto"
        static let token = "/auth/jwt"
        static let signup = "/auth/signup"
        static let revokeApple = "/auth/revoke/apple"
        static let loginApple = "/auth/apple/token"
        //USER
        static let signout = "/users/signout"
        //TODO
        static let sticker = "/todo"
        //CATEGORY
        static let category = "/category"
        //DIARY
        static let diary = "/diary/:createdDate"
    }
    
    struct PUT{
        static let sticker = "/diary/:createdDate/sticker"
    }

    struct PATCH {
        //AUTH
        static let password = "/auth/password"
        //USER
        static let profile = "/users/profile"
        static let imageUpdate = "/users/profile-img"
        static let imageDelete = "/users/profile-img/default"
        static let userDelete = "/users/status"
        static let todoAlarmActivate = "/users/alarm/todo"
        static let diaryAlarmActivate = "/users/alarm/diary"
        static let remindAlarmActivate = "/users/alarm/remind"
        static let marketing = "/users/service/terms"
        //TODO
        static let todo = "/todo/:todoId"
        static let todoCheckbox = "/todo/check"
        static let todoPin = "/todo/pin"
        static let todoAlarm = "/todo/:todoId/alarm"
        //CATEGORY
        static let category = "/category"
    }
    
    struct DELETE {
        //TODO
        static let todo = "/todo/:todoId"
        //CATEGORY
        static let category = "/category"
        //DIARY
        static let diary = "/diary/:createdDate"
    }
    
}
