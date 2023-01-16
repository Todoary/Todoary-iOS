//
//  DiaryTextModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation

struct DiaryRequestModel: Codable{
    let title: String
    let content: String
}

struct DiaryResultModel: Codable{
    let diaryId: Int
    var title: String
    var content: String
    let created_at: String
}
