//
//  GetCalendarModel.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/01.
//

struct GetCalendarModel: Decodable{
    var isSuccess: Bool
    var code: Int
    var message : String
    var result : [Int]
}
