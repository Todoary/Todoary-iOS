//
//  File.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/07.
//

import Foundation

struct GeneralResponse<T> {
    let isSuccess: Bool
    let code: Int
    let message: String?
    let result: T?
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case result
    }
}

extension GeneralResponse: Decodable where T: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isSuccess = try container.decode(Bool.self, forKey: .isSuccess)
        code = try container.decode(Int.self, forKey: .code)
        message = try? container.decode(String.self, forKey: .message)
        result = try? container.decode(T.self, forKey: .result)
    }
}
