//
//  CollectionViewCell.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    var photo: Photo? = nil {
        didSet { updateContent() }
    }
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(photo: Photo) {
        self.photo = photo
    }
    
    override func prepareForReuse() {
        photo = nil
    }
    
    private func updateContent() {
        guard let photo = self.photo else {
            imageView.imageFromUrlString("") // set a default image
            return
        }
        imageView.imageFromUrlString(photo.urls.small)
    }
}
