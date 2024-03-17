//
//  RequestProtocol.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import Alamofire

protocol RequestProtocol {
    associatedtype Response: Decodable
    associatedtype Parameters: Encodable
    
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders { get }
    var encoder: ParameterEncoder? { get }
    
}

extension RequestProtocol {
    var scheme: String {
        APIConstants.scheme
    }

    var host: String {
        APIConstants.host
    }
}
