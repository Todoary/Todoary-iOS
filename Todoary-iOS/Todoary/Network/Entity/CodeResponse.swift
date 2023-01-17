//
//  CodeResponse.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/17.
//

import Foundation

struct CodeResponse{
    let isSuccess: Bool
    let code: Int
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
    }
}

extension CodeResponse: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isSuccess = try container.decode(Bool.self, forKey: .isSuccess)
        code = try container.decode(Int.self, forKey: .code)
        message = try? container.decode(String.self, forKey: .message)
    }
    
}
