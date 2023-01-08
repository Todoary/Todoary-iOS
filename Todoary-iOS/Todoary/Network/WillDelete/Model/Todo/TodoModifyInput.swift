//
//  TodoModifyInput.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/02.
//

struct TodoModifyInput : Encodable {
    var title : String
    var targetDate : String
    var isAlarmEnabled : Bool
    var targetTime : String
    var categoryId : Int
}
