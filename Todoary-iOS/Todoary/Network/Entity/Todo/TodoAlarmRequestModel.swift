//
//  TodoAlarmRequestModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/17.
//

import Foundation

struct TodoAlarmRequestModel: Codable{
    let targetDate: String
    let isAlarmEnabled: Bool
    let targetTime: String
}
