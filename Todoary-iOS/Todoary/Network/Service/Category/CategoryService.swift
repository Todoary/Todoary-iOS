//
//  CategoryService.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/07.
//

import Foundation

class CategoryService: BaseService{
    static let shared = CategoryService()
    private override init() {}
}

extension CategoryService {
    
    func getCategories(completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(CategoryRouter.getCategories, type: [CategoryModel].self, decodingMode: .model, completion: completion)
    }
    
    func generateCategory(request: CategoryMakeInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(CategoryRouter.postCategory(requeset: request), completion: completion)
    }
    
    func modifyCategory(id: Int, request: CategoryMakeInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(CategoryRouter.fetchCategory(id: id, request: request), completion: completion)
    }
    
    func deleteCategory(id: Int, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(CategoryRouter.deleteCategory(id: id), completion: completion)
    }
}
