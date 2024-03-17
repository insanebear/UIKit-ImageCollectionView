//
//  RequestManagerProtocol.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import Foundation

protocol RequestManagerProtocol {
    func perform<T: RequestProtocol>(_ request: T) async throws -> T.Response
}
