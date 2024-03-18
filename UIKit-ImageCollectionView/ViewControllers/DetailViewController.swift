//
//  DetailViewController.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/18/24.
//

import UIKit

class DetailViewController: UIViewController {
    var photo: Photo? = nil {
        didSet { updateContent() }
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    } ()

    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(Device.width)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func configure(photo: Photo) {
        self.photo = photo
    }
    
    private func updateContent() {
        guard let photo = self.photo else {
            imageView.setDefaultImage()
            return
        }
        imageView.imageFromUrlString(photo.urls.regular)
        
        print(photo.user.username)
    }
}
