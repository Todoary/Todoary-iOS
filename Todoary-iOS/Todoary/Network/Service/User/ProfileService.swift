//
//  ProfileService.swift
//  Todoary
//
//  Created by 송채영 on 2023/01/11.
//

import Foundation

class ProfileService: BaseService{
    static let shared = ProfileService()
    private override init() {}
}

extension ProfileService {
    
    func getProfile(completion: @escaping (NetworkResult<Any>) -> Void){
        requestObject(ProfileRouter.getProfile, type: [ProfileGetModel].self, decodingMode: .model, completion: completion)
    }
    
    func modifyProfile(request: ProfileInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(ProfileRouter.patchProfile(requeset: request), completion: completion)
    }
    
    func modifyProfileImage(request: ProfileImgInput, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(ProfileRouter.patchProfileImage(request: request), completion: completion)
    }
    
    func deleteProfileImage(completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(ProfileRouter.deleteProfileImage, completion: completion)
    }
}
