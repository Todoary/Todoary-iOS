//
//  HeaderType.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/07.
//

import Foundation

enum HeaderType {
    case `default`
    case withToken
    case multiPart
    case multiPartWithToken
    case reissuance
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case accesstoken = "Authorization" 
    case refreshtoken = "refreshtoken"
}

enum HeaderContent: String {
    case json = "application/json"
    case multiPart = "multipart/form-data"
//    case tokenSerial = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyZDRlODRmMGZmMmY5MDBlYTg4YmVjMyIsImlhdCI6MTY1ODMyNTUwOCwiZXhwIjoxNjU4NTg0NzA4fQ.ND6-ZIthGE4LRjYtZnWyqc0pJluiUYO_Vb_9gkmETLw"
}