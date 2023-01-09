//
//  BaseRouter.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/07.
//

import Foundation
import Alamofire

final class UserManager{
    static let shared = UserManager()
    
    let getAccessToken = UserDefaults.standard.string(forKey: "accessToken")!
    let getRefreshToken = UserDefaults.standard.string(forKey: "refreshToken")!
}

protocol BaseRouter: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
    var header: HeaderType { get }
    var multipart: MultipartFormData { get }
}

// MARK: asURLRequest()

extension BaseRouter {
    
    // URLRequestConvertible 구현
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        
        urlRequest = self.makeHeaderForRequest(to: urlRequest)
        
        return try self.makeParameterForRequest(to: urlRequest, with: url)
    }
    
    private func makeHeaderForRequest(to request: URLRequest) -> URLRequest {
        var request = request
        
        switch header {
            
        case .default:
            request.setValue(HeaderContent.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            
        case .withToken:
            request.setValue(HeaderContent.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            request.setValue(UserManager.shared.getAccessToken, forHTTPHeaderField: HTTPHeaderField.accesstoken.rawValue)
            
        case .multiPart:
            request.setValue(HeaderContent.multiPart.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            
        case .multiPartWithToken:
            request.setValue(HeaderContent.multiPart.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            request.setValue(UserManager.shared.getAccessToken, forHTTPHeaderField: HTTPHeaderField.accesstoken.rawValue)
            
        case .reissuance:
            request.setValue(HeaderContent.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            request.setValue(UserManager.shared.getAccessToken, forHTTPHeaderField: HTTPHeaderField.accesstoken.rawValue)
            request.setValue(UserManager.shared.getRefreshToken, forHTTPHeaderField: HTTPHeaderField.refreshtoken.rawValue)
        }
        
        return request
    }
    
    private func makeParameterForRequest(to request: URLRequest, with url: URL) throws -> URLRequest {
        var request = request
        
        switch parameters {
            
        case .query(let query):
            let queryParams = query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            request.url = components?.url
            
//            let percentEncodedQuery = (components?.percentEncodedQuery.map { $0 + "&" } ?? "") + self.query(query)
//            components?.percentEncodedQuery = percentEncodedQuery
//            request.url
//            request.url = components?.url
            
        case .requestBody(let body):
            
            //추가 부분
            let data = try JSONEncoder().encode(body)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else { throw NSError() }
            
            request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: [])
//            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            
        case .queryBody(let query, let body):
            let queryParams = query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            request.url = components?.url
            
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            
        case .requestPlain:
            break
        }
        
        return request
    }
}

// MARK: baseURL & header

extension BaseRouter {
    var baseURL: String {
        return "https://todoary.com"
    }
    
    var header: HeaderType {
        return HeaderType.withToken
    }
    
    var multipart: MultipartFormData {
        return MultipartFormData()
    }
}

// MARK: ParameterType

enum RequestParams {
    case queryBody(_ query: [String: Any], _ body: [String: Any])
    case query(_ query: [String: Any])
//    case requestBody(_ body: [String: Any])
    case requestBody(_ body: Encodable)
    case requestPlain
}