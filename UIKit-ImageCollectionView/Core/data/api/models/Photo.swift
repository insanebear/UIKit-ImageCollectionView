//
//  Photo.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import Foundation

struct Photo: Decodable {
    let uuid = UUID() // to make Photo struct unique.
    
    let id: String
    let width: Int
    let height: Int
    let urls: PhotoURLs
    
    private enum CodingKeys: String, CodingKey {
        // to supress the warning that suggest to modify `let uuid` to `var`
        case id, width, height, urls
    }
      
}

extension Photo: Hashable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
