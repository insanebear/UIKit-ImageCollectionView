//
//  DetailViewController.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/18/24.
//

import UIKit

class DetailViewController: UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        let label = UILabel()
        
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
