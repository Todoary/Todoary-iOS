//
//  TodoIndividualModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation


struct TodoAlarmRequestModel: Codable{
    let targetDate: String
    let isAlarmEnabled: Bool
    let targetTime: String
}

struct TodoResultModel: Codable{
    let todoId: Int
    var isPinned: Bool //cateogry 받아올 때는 없는데, Model에서도 제외시커야 하나..?
    var isChecked: Bool
    var title: String
    var targetDate: String
    var isAlarmEnabled: Bool
    var targetTime: String?
    let createdTime: String
    var categoryId: Int
    let categoryTitle: String
    let color: Int
}
