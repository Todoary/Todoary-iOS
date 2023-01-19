//
//  AlarmActiveStautsResultModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation

struct AlarmActiveStautsResultModel: Codable{
    var isTodoAlarmChecked: Bool = false
    var isDiaryAlarmChecked: Bool = false
    var isRemindAlarmChecked: Bool = false
}
