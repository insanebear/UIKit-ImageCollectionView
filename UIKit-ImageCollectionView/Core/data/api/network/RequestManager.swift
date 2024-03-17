//
//  RequestManager.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import Foundation

class RequestManager: RequestManagerProtocol {
    static let shared = RequestManager(apiManager: APIManager.shared) // At this point, use one APIManager.
    
    let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func perform<T : RequestProtocol>(_ request: T) async throws -> T.Response {
        let response = try await apiManager.perform(request)
        return response
    }
}
