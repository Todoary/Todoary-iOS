//
//  DiaryStickerResultModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/17.
//

import Foundation

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
