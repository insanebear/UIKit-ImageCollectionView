//
//  UIImageView.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import UIKit

extension UIImageView {
    func imageFromUrlString(_ urlString: String) {
        let defaultImage = UIImage(systemName: "questionmark.square.dashed")
        
        guard let url = URL(string: urlString) else {
            self.image = defaultImage
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = try? Data(contentsOf: url) else {
                self.image = defaultImage
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
