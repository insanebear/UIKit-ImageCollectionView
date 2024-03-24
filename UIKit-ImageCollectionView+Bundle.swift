//
//  UIKit-ImageCollectionView+Bundle.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import Foundation

extension Bundle {
    var apiKey: String {
        // !!!: Please enter your Unsplash API Key for API_KEY in UnsplashInfo.plist.
        
        guard let file = self.path(forResource: "UnsplashInfo", ofType: "plist") else {
            fatalError("Cannot find `UnsplashInfo.plist` file.")
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: file)),
              let dict = try? PropertyListSerialization.propertyList(from: data, format: nil) as? NSDictionary else {
            
            fatalError("Cannot load plist file.")
        }
        
        guard let key = dict["API_KEY"] as? String else { fatalError("Enter your api key in API_KEY of UnsplashInfo") }
        return key
    }
}
