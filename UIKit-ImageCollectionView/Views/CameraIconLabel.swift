//
//  CameraIconLabel.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/18/24.
//

import UIKit

class CameraIconLabel: UIStackView {
    
    private let iconImageView: UIImageView = {
        let cameraImage = UIImage(systemName: "camera")
        let view = UIImageView(image: cameraImage)
        view.contentMode = .scaleAspectFit
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.tintColor = .defaultTextColor
        return view
    } ()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .defaultTextColor
        return label
    } ()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.alignment = .center
        self.spacing = Spacing.standard
        self.addArrangedSubview(iconImageView)
        self.addArrangedSubview(textLabel)
        self.fitSubviewsToVertical()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        textLabel.text = text
    }
}
