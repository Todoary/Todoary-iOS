//
//  CategoryModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/07.
//

import Foundation

struct CategoryModel : Codable, Equatable {
    var id : Int! = nil
    var title : String
    var color : Int
    
    static func ==(lhs: CategoryModel, rhs: CategoryModel) -> Bool {
        return lhs.id == rhs.id
    }
}
