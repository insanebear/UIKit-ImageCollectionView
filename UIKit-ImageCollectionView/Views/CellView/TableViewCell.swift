//
//  TableViewCell.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/19/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    
    let photoSize: CGFloat = Device.width/5
    
    private var photo: Photo? = nil {
        didSet { updateContent() }
    }

    private let customImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.clipsToBounds = true
        view.snp.makeConstraints { make in
            make.width.equalTo(view.snp.height)
        }
        return view
    } ()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .defaultTextColor
        return label
    } ()
    
    private let createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.textColor = .defaultTextColor
        return label
    } ()
    
    private let likeLabel = IconLabel(icon: .heart, axis: .vertical)
    
    let container: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = Spacing.standard
        stack.alignment = .center
        
        return stack
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupImageView()
        setupLabelStack()
        self.container.addArrangedSubview(UIView()) // Spacer
        setupLikeLabel()
    }
    
    private func setupImageView() {
        self.container.addArrangedSubview(customImageView)
        customImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
        }
    }
    
    private func setupLabelStack() {
        let stack = UIStackView(arrangedSubviews: [usernameLabel, createdAtLabel])
        stack.axis = .vertical
        stack.spacing = Spacing.standard
        stack.alignment = .leading
        
        stack.fitSubviewsToHorizontal()
        
        self.container.addArrangedSubview(stack)
        stack.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
        }
    }
    
    private func setupLikeLabel() {
        let stack = UIStackView(arrangedSubviews: [UIView(), likeLabel, UIView()])
        stack.axis = .vertical
        stack.alignment = .center
        self.container.addArrangedSubview(stack)
    }

    private func updateContent() {
        guard let photo = self.photo else {
            customImageView.image = nil
            usernameLabel.text = nil
            createdAtLabel.text = nil
            likeLabel.configure(text: "")
            return
        }
        customImageView.imageFromUrlString(photo.urls.small)
        usernameLabel.text = photo.user.username
        createdAtLabel.text = photo.createdAt
        likeLabel.configure(text: "\(photo.likes)")
        
//        customImageView.snp.makeConstraints { make in
//            make.width.equalTo(photoSize)
//        }
//
    }
    
    func configure(photo: Photo) {
        self.photo = photo
    }
    
    override func prepareForReuse() {
        self.photo = nil
    }
}
