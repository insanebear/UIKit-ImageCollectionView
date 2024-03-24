//
//  UIImageView.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import UIKit

extension UIImageView {
    func setDefaultImage() {
        let defaultImage = UIImage(systemName: "questionmark.square.dashed")
        self.image = defaultImage
    }
    
    func imageFromUrlString(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            setDefaultImage()
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = try? Data(contentsOf: url) else {
                self.setDefaultImage()
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
