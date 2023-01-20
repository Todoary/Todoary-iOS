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
    
    func getProfile(viewcontroller: UIViewController, completion: @escaping (NetworkResult<Any>) -> Void){
        AFManager.request(ProfileRouter.getProfile, interceptor: Interceptor()).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return}
                let networkResult = self.judgeStatus(by: statusCode, data, type: ProfileResultModel.self, decodingMode: .model)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func modifyProfile(request: ProfileRequestModel, completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(ProfileRouter.patchProfile(requeset: request), completion: completion)
    }
    
    func deleteProfileImage(completion: @escaping (NetworkResult<Any>) -> Void){
        requestObjectWithEmptyResponse(ProfileRouter.deleteProfileImage, completion: completion)
    }
    
    func modifyProfileImage (image: UIImage, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        AFManager.upload(multipartFormData: ProfileRouter.patchProfileImage(image: image).multipart, with: ProfileRouter.patchProfileImage(image: image)).responseData { response in
            switch(response.result) {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatusWithEmptyReponse(by: statusCode, data, decodingMode: .code)
                completion(networkResult)
            case .failure(let err) :
                print(err.localizedDescription)
            }
        }
    }
}
