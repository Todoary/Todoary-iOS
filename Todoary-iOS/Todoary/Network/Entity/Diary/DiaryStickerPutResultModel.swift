//
//  DiaryStickerPutResultModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/17.
//

import Foundation

struct DiaryStickerPutResultModel : Codable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [Int]
}
