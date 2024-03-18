//
//  UIStackView.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/18/24.
//

import UIKit

extension UIStackView {
    func fitSubviewsToHorizontal(inset: CGFloat = 0) {
        for view in self.arrangedSubviews {
            view.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(inset)
            }
        }
    }
    
    func fitSubviewsToVertical(inset: CGFloat = 0) {
        for view in self.arrangedSubviews {
            view.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview().inset(inset)
            }
        }
    }
}
