//
//  BaseService.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/07.
//

import Foundation
import Alamofire

class BaseService {
    
//    var disposeBag = DisposeBag()
    
    @frozen enum DecodingMode {
        case model
        case code
        case message
        case general
    }
    
    let AFManager: Session = {
        var session = AF
//        let configuration = URLSessionConfiguration.af.default
//        configuration.timeoutIntervalForRequest = NetworkEnvironment.requestTimeOut
//        configuration.timeoutIntervalForResource = NetworkEnvironment.resourceTimeOut
//        let eventLogger = APIEventLogger()
//        session = Session(configuration: configuration, interceptor: eventLogger, eventMonitors: [eventLogger])
        return session
    }()
    
//    let RxAFManager: Session = {
//        var session = Session.default
//        let configuration = URLSessionConfiguration.af.default
//        configuration.timeoutIntervalForRequest = NetworkEnvironment.requestTimeOut
//        configuration.timeoutIntervalForResource = NetworkEnvironment.resourceTimeOut
//        let eventLogger = APIEventLogger()
//        session = Session(configuration: configuration, eventMonitors: [eventLogger])
//        return session
//    }()
    
    func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, type: T.Type, decodingMode: DecodingMode = .general) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GeneralResponse<T>.self, from: data)
        else { return .pathErr }

        switch statusCode {
        case 200..<300:
            
            switch decodingMode {
            case .model:
                if(decodedData.code == 1000){
                    return .success(decodedData.result ?? "None-Data")
                }else{
                    return .invalidSuccess(decodedData.code)
                }
            case .code:
                return .success(decodedData.code)
            case .message:
                return .success(decodedData.message ?? "None-Data")
            case .general:
                return .success(decodedData)
            }
            
        case 400..<500:
            return .requestErr(decodedData)
            
        case 500:
            return .serverErr
            
        default:
            return .networkFail
        }
    }
    
    func requestObject<T: Codable>(_ target: BaseRouter,
                                   type: T.Type,
                                   decodingMode: DecodingMode,
                                   completion: @escaping (NetworkResult<Any>) -> Void) {
        AFManager.request(target, interceptor: Interceptor()).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return}
                let networkResult = self.judgeStatus(by: statusCode, data, type: type, decodingMode: decodingMode)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func requestObjectWithEmptyResponse(_ target: BaseRouter,
                                        decodingMode: DecodingMode = .code,
                                   completion: @escaping (NetworkResult<Any>) -> Void) {
        AFManager.request(target, interceptor: Interceptor()).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return}
                let networkResult = self.judgeStatusWithEmptyReponse(by: statusCode, data, decodingMode: decodingMode)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func judgeStatusWithEmptyReponse(by statusCode: Int, _ data: Data, decodingMode: DecodingMode = .general) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(CodeResponse.self, from: data)
        else { return .pathErr }

        switch statusCode {
        case 200..<300:
            
            switch decodingMode {
            case .code, .model:
                if(decodedData.code == 1000){
                    return .success(())
                }else{
                    return .invalidSuccess(decodedData.code)
                }
            case .message:
                return .success(decodedData.message ?? "None-Data")
            case .general:
                return .success(decodedData)
            }
            
        case 400..<500:
            return .requestErr(decodedData)
            
        case 500:
            return .serverErr
            
        default:
            return .networkFail
        }
    }

}
