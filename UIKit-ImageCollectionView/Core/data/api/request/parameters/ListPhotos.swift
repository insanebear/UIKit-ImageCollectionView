//
//  ListPhotos.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import Foundation

struct ListPhotos: Encodable {
    let page: Int
    let perPage: Int
    let orderBy: SortOrder
    
    init(page: Int, perPage: Int, orderBy: SortOrder) {
        self.page = page
        self.perPage = perPage
        self.orderBy = orderBy
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case orderBy = "order_by"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(page, forKey: .page)
        try container.encode(perPage, forKey: .perPage)
        try container.encode(orderBy, forKey: .orderBy)
    }
}

extension ListPhotos {
    enum SortOrder: String, Encodable {
        case latest, oldest, popular
    }
}
