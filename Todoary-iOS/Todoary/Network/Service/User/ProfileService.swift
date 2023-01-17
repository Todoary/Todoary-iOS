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
//        requestObjectWithEmptyResponse(ProfileRouter.patchProfile(requeset: request), completion: completion)
    }
    
    func deleteProfileImage(completion: @escaping (NetworkResult<Any>) -> Void){
//        requestObjectWithEmptyResponse(ProfileRouter.deleteProfileImage, completion: completion)
    }
    
    func modifyProfileImage (image: UIImage, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        AFManager.upload(multipartFormData: ProfileRouter.patchProfileImage(image: image).multipart, with: ProfileRouter.patchProfileImage(image: image)).responseData { response in
            switch(response.result) {
            case .success:
//                let networkResult = self.judgeStatusWithEmptyReponse(by: response.response?.statusCode)
//                completion(networkResult)
                break
            case .failure(let err) :
                print(err.localizedDescription)
            }
        }
    }
}
