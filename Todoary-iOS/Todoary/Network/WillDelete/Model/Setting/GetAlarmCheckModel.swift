//
//  GetAlarmCheckResult.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/02.
//

import UIKit

struct GetAlarmCheckModel: Decodable{
    var isSuccess: Bool?
    var code: Int
    var message: String
    var result: GetAlarmCheckResult
}

struct GetAlarmCheckResult: Decodable{
    var isTodoAlarmChecked: Bool
    var isDiaryAlarmChecked: Bool
    var isRemindAlarmChecked: Bool
}
