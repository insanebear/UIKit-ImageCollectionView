//
//  IconLabel.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/18/24.
//

import UIKit

class IconLabel: UIStackView {
    
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .defaultTextColor
        return view
    } ()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .defaultTextColor
        label.sizeToFit()
        return label
    } ()
    
    convenience init(icon: Icon, axis: NSLayoutConstraint.Axis = .horizontal) {
        self.init(frame: .zero)
        iconImageView.image = icon.image
        self.axis = axis
        
        if self.axis == .horizontal {
            self.fitSubviewsToVertical()
            iconImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        } else {
            self.fitSubviewsToHorizontal()
            iconImageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
            textLabel.textAlignment = .center
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.alignment = .center
        self.spacing = Spacing.standard
        self.addArrangedSubview(iconImageView)
        self.addArrangedSubview(textLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        textLabel.text = text
    }
}

extension IconLabel {
    enum Icon {
        case camera, heart
        
        var image: UIImage? {
            switch self {
                
            case .camera:
                return UIImage(systemName: "camera")
            case .heart:
                return UIImage(systemName: "heart.fill")
            }
        }
    }
}
