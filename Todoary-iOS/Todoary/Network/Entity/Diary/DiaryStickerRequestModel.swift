//
//  DiaryStickerRequestModel.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/22.
//

import Foundation

struct DiaryStickerRequestModel: Encodable{
    let created: [CreatedDiaryStickerRequestModel]
    let modified: [ModifiedDiaryStickerRequestModel]
    let deleted: [Int]
}

struct CreatedDiaryStickerRequestModel: Encodable{
    let stickerId: Int
    let locationX: Double
    let locationY: Double
    let width: Double
    let height: Double
    let rotation: Double
    let flipped: Bool
}

struct ModifiedDiaryStickerRequestModel: Encodable{
    let id: Int
    let stickerId: Int
    let locationX: Double
    let locationY: Double
    let width: Double
    let height: Double
    let rotation: Double
    let flipped: Bool
}
