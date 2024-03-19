//
//  UserProfileView.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/18/24.
//

import UIKit

class UserProfileView: UIView {
    static let photoSize: CGFloat = Device.width/5
    
    private var user: User? = nil {
        didSet { updateContent() }
    }
    
    private let userPhotoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.snp.makeConstraints { make in
            make.width.height.equalTo(photoSize)
        }
        return view
    } ()
    
    private let numOfTotalPhotosLabel = CameraIconLabel()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .defaultTextColor
        return label
    } ()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .defaultTextColor
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserPhotoView()
        setupUserNameBioView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUserPhotoView() {
        
        let stack = UIStackView(arrangedSubviews: [userPhotoView, numOfTotalPhotosLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = Spacing.standard
        stack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        self.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.width.equalTo(UserProfileView.photoSize)
        }
        userPhotoView.layer.cornerRadius = UserProfileView.photoSize / 2
        userPhotoView.clipsToBounds = true
    }
    
    private func setupUserNameBioView() {
        
        let bioTitle = UILabel()
        bioTitle.text = "Bio"
        bioTitle.font = UIFont.preferredFont(forTextStyle: .headline)
        bioTitle.textColor = .defaultTextColor
        bioTitle.textAlignment = .left
        
        let bioLabelStack = UIStackView(arrangedSubviews: [bioTitle, bioLabel])
        bioLabelStack.axis = .vertical
        bioLabelStack.alignment = .leading
        bioLabelStack.spacing = Spacing.standard
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, bioLabelStack])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = Spacing.standard
        stack.fitSubviewsToHorizontal()
        
        self.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
            
            if let firstView = self.subviews.first {
                make.leading.equalTo(firstView.snp.trailing).inset(-8)
            }
        }
    }
    
    private func updateContent() {
        guard let user = self.user else { fatalError("No user info") }
        
        userPhotoView.imageFromUrlString(user.profileImage)
        numOfTotalPhotosLabel.configure(text: "\(user.totalPhotos)")
        usernameLabel.text = user.username
        bioLabel.text = user.bio ?? "."
    }
    
    func configure(user: User) {
        self.user = user
    }
}
