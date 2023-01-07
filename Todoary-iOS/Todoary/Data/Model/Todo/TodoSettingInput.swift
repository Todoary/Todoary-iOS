//
//  TodoSettingInput.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/27.
//

struct TodoSettingInput : Encodable {
    var title : String?
    var targetDate : String?
    var isAlarmEnabled : Bool?
    var targetTime : String?
    var categoryId : Int?
}
