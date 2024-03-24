//
//  DetailViewController.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/18/24.
//

import UIKit

class DetailViewController: UIViewController {
    private var photo: Photo? = nil {
        didSet { updateContent() }
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    } ()
    
    private let userProfileView = UserProfileView()

    override func viewDidLoad() {
        self.view.backgroundColor = .backgroundColor
        
        self.view.addSubview(imageView)
        self.view.addSubview(userProfileView)
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(Device.width)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        userProfileView.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).inset(-Spacing.standard)
            make.horizontalEdges.equalToSuperview().inset(Spacing.standard)
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
        userProfileView.configure(user: photo.user)
    }
}
