//
//  TableViewDataSource.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/19/24.
//

import UIKit

class TableViewDataSource: UITableViewDiffableDataSource<Int, Photo> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Photo>
    
    private let cellProvider: (UITableView, IndexPath, Photo) -> UITableViewCell?

    override init(tableView: UITableView, cellProvider: @escaping (UITableView, IndexPath, Photo) -> UITableViewCell?) {
        self.cellProvider = cellProvider
        
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            cellProvider(tableView, indexPath, itemIdentifier)
        }
        
        // register a cell for the table view
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "\(TableViewCell.self)")
    }

    
    func updateSnapshot(dataList: [Photo]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(dataList)
        
        apply(snapshot, animatingDifferences: false)
    }
}
