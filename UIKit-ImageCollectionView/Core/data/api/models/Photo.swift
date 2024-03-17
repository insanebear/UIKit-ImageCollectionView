//
//  Photo.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let width: Int
    let height: Int
    let urls: PhotoURLs
}
