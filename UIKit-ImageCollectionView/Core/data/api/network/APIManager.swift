//
//  APIManager.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import Alamofire

class APIManager: APIManagerProtocol {
    static let shared = APIManager()
    
    func perform<T: RequestProtocol>(_ request: T) async throws -> T.Response {
        let url = "\(request.scheme)://\(request.host)\(request.endpoint)"
        
        // create a request,
        // then if it succeeded, decode the response using T.Response.self
        let task = AF.request(url,
                              method: request.method,
                              parameters: request.parameters,
                              encoder: request.encoder ?? URLEncodedFormParameterEncoder.default,
                              headers: request.headers)
            .validate(statusCode: 200..<400)
            .serializingDecodable(T.Response.self)
        
        let result = await task.result
        
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            debugPrint(error)
            throw error
        }
    }
}
