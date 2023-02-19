//
//  BaseProtocol.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/25.
//

import UIKit

protocol CellReuseProtocol{ //cell 사용은 아래 예제처럼
    static var cellIdentifier: String { get }
}

extension CellReuseProtocol{
    static var cellIdentifier: String{
        return String(describing: self)
    }
}
