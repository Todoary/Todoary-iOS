//
//  TodoRequestModel.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/22.
//

import Foundation
struct TodoRequestModel : Codable {
    var title : String
    var targetDate : String
    var isAlarmEnabled : Bool
    var targetTime : String
    var categoryId : Int
}
