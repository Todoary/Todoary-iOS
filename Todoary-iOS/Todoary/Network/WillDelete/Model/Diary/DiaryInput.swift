//
//  DiaryInput.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/17.
//

import Foundation

struct DiaryInput: Encodable{
    let title: String
    let content: String
}

struct DiaryStickerInput: Encodable{
    let created: [CreatedDiarySticker]
    let modified: [ModifiedDiarySticker]
    let deleted: [Int]
}

struct CreatedDiarySticker: Encodable{
    let stickerId: Int
    let locationX: Double
    let locationY: Double
    let width: Double
    let height: Double
    let rotation: Double
    let flipped: Bool
}

struct ModifiedDiarySticker: Encodable{
    let id: Int
    let stickerId: Int
    let locationX: Double
    let locationY: Double
    let width: Double
    let height: Double
    let rotation: Double
    let flipped: Bool
}


