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
    
    func generateCategory(request: CategoryModel, completion: @escaping (NetworkResult<Any>) -> Void){
        print("요청")
        requestObject(CategoryRouter.getCategories, type: Int.self, decodingMode: .model, completion: completion)
        
//        requestObjectWithEmptyResponse(CategoryRouter.postCategory(requeset: request), completion: completion)
    }
    
    func modifyCategory(id: Int, request: CategoryModel, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(CategoryRouter.patchCategory(id: id, request: request), completion: completion)
    }
    
    func deleteCategory(id: Int, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(CategoryRouter.deleteCategory(id: id), completion: completion)
    }
}
