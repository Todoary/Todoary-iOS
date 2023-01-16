//
//  DiaryModel.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/12.
//

import Foundation

//MARK: - Text
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

//MARK: - Sticker
struct DiaryStickerPutResultModel : Codable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [Int]
}

struct DiaryStickerResultModel : Codable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [DiaryStickerList]
}

struct DiaryStickerList: Codable{
    let id : Int
    let diaryId : Int
    let stickerId: Int
    let locationX: Double
    let locationY: Double
    let width: Double
    let height: Double
    let rotation: Double
    let flipped: Bool
}
