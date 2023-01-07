//
//  DiaryStickerModel.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/24.
//

struct DiaryStickerModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [Int]
}

struct GetDiaryStickerModel : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [DiarySticker]
}

struct DiarySticker: Decodable{
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
