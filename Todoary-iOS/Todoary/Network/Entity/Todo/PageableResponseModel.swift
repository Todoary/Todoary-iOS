//
//  PageableResponseModel.swift
//  Todoary
//
//  Created by 박소윤 on 2023/02/20.
//

import Foundation

struct PageableResponseModel: Codable{
    
    let contents: [TodoResultModel]
    let pageInfo: PageInfoResponseModel
    
    struct PageInfoResponseModel: Codable{
        let empty: Bool
        let last: Bool
    }
}

extension PageableResponseModel{
    
    var isEmpty: Bool{
        pageInfo.empty
    }
    
    var isLast: Bool{
        pageInfo.last
    }
}
