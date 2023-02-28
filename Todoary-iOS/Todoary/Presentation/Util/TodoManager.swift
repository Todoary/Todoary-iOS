//
//  TodoManager.swift
//  Todoary
//
//  Created by 박소윤 on 2023/02/28.
//

import Foundation

class TodoManager{
    static let shared = TodoManager()
    private init(){ }
    
    var isAdd = false
    
    func initialize(){
        isAdd = false
    }
}
