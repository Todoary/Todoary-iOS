//
//  DiaryResultModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/17.
//

import Foundation

struct DiaryResultModel: Codable{
    let diaryId: Int
    var title: String
    var content: String
    let created_at: String
}
