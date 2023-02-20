//
//  Pageable.swift
//  Todoary
//
//  Created by 박소윤 on 2023/02/20.
//

import Foundation

protocol Pageable{
    var page: Int { get set }
    var hasNextPage: Bool { get set }
    var isPaging: Bool { get set }
    func beginPaging()
    func todoRequestIsEmpty()
}
