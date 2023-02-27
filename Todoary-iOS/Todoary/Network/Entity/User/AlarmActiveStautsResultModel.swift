//
//  AlarmActiveStautsResultModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation

struct AlarmActiveStautsResultModel: Codable{
    var toDoAlarmEnable: Bool = false
    var dailyAlarmEnable: Bool = false
    var remindAlarmEnable: Bool = false
}
