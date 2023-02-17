//
//  SummaryCellDelegate.swift
//  Todoary
//
//  Created by 박소윤 on 2023/02/17.
//

import Foundation

protocol SummaryCellDelegate{
    func willShowAddTodoOrDiaryButton()
    func willMoveCategoryViewController()
    func willShowDiaryDeleteAlert()
}
