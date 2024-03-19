//
//  TabBarViewController.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/19/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let subViewControllers = TabItem.allCases.map {
            // set each tab bar item
            let vc = $0.viewController
            vc.tabBarItem = $0.tabBarItem
            return vc
        }
        
        // set subViewControllers to UITabBarController
        self.viewControllers = subViewControllers
    }
}

extension TabBarViewController {
    enum TabItem: CaseIterable {
        case table, collection 
        
        var title: String {
            switch self {
                
            case .collection:
                return "Collection"
            case .table:
                return "Table"
            }
        }
        
        var icon: String {
            switch self {
                
            case .collection:
                return "square.grid.2x2"
            case .table:
                return "rectangle.grid.1x2"
            }
        }
        
        var filledIcon: String {
            switch self {
                
            case .collection:
                return "square.grid.2x2.fill"
            case .table:
                return "rectangle.grid.1x2.fill"
            }
        }
        
        var viewController: UIViewController {
            switch self {
                
            case .collection:
                return CollectionViewController()
            case .table:
                return TableViewController()
            }
        }
        
        var tabBarItem: UITabBarItem {
            return UITabBarItem(title: self.title,
                                image: UIImage(systemName: self.icon),
                                selectedImage: UIImage(systemName: self.filledIcon))
        }
    }
}
