//
//  PhotoRequest.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import Alamofire

struct ListPhotosRequest: RequestProtocol {
    
    typealias Response = [Photo]
    
    typealias Parameters = ListPhotos
    
    var endpoint: String = "/photos"
    
    var method: Alamofire.HTTPMethod = .get

    var parameters: Parameters? = nil
    
    var headers: Alamofire.HTTPHeaders = ["Authorization": "\(APIConstants.apiKey)",
                                          "Accept": "application/json"]
    
    var encoder: Alamofire.ParameterEncoder? = URLEncodedFormParameterEncoder.default
    
    
}
