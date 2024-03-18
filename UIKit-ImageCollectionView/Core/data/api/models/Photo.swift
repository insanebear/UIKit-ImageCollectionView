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
    let createdAt: String
    let likes: Int
    let description: String?
    let user: User
    
    private enum CodingKeys: String, CodingKey {
        case id, width, height, urls, likes, description, user
        case createdAt = "created_at"
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
