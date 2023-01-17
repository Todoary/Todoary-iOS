//
//  NetworkResult.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/07.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case invalidSuccess(Int)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
