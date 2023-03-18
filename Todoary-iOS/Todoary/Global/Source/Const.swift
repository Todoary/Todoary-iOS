//
//  Const.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/22.
//

import Foundation

struct Const{
    
    struct Device{
        static let DEVICE_HEIGHT = UIScreen.main.bounds.size.height
        static let DEVICE_WIDTH = UIScreen.main.bounds.size.width
        static let isSmallDevice = Device.DEVICE_HEIGHT <= 736
    }
    
    struct Offset{
        static let top = Device.isSmallDevice ? 75 : 95
    }
    
    struct UserDefaults{
        static let appleRefreshToken = "APPLE_REFRESH_TOKEN"
        static let appleIdentifier = "APPLE_IDENTIFIER"
        static let providerId = "PROVIDER_ID"
        static let email = "APPLE_EMAIL"
        static let userName = "APPLE_USERNAME"
    }
}
