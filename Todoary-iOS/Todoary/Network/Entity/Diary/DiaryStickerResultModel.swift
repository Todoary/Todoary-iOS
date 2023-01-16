//
//  DiaryStickerResultModel.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/12.
//

import Foundation

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
