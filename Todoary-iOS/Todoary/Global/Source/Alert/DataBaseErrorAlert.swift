//
//  DataBaseErrorAlert.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import UIKit

class DataBaseErrorAlert: UIAlertController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "서버 오류"
        self.message = "서버에서 오류가 발생했습니다. 잠시 후 다시 시도해주세요."
        
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        self.addAction(alertAction)
        
    }

}
