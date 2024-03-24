//
//  User.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/18/24.
//

import Foundation

struct User: Decodable {
    let username: String
    let bio: String?
    let profileImage: String
    let totalPhotos: Int
    
    private enum CodingKeys: String, CodingKey {
        case username, bio
        case profileImage = "profile_image"
        case totalPhotos = "total_photos"
    }
    
    private enum ProfileCodingKeys: String, CodingKey {
        case small, medium, large
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        username = try container.decode(String.self, forKey: .username)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        
        let profileImagesContainer = try container.nestedContainer(keyedBy: ProfileCodingKeys.self, forKey: .profileImage)
        profileImage = try profileImagesContainer.decode(String.self, forKey: .medium)
        totalPhotos = try container.decode(Int.self, forKey: .totalPhotos)
    }
}
