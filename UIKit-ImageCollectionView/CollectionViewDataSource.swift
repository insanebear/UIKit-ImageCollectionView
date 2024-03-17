//
//  CollectionViewDataSource.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import UIKit

class CollectionViewDataSource: UICollectionViewDiffableDataSource<Int, Int> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Int>
    
    private let cellProvider: (UICollectionView, IndexPath, Int) -> UICollectionViewCell?

    override init(collectionView: UICollectionView, cellProvider: @escaping (UICollectionView, IndexPath, Int) -> UICollectionViewCell?) {
        self.cellProvider = cellProvider
        
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            cellProvider(collectionView, indexPath, itemIdentifier)
        }
        
        // register a cell for the collection view
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "\(CollectionViewCell.self)")
    }

    
    func updateSnapshot(dataList: [Int]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(dataList)
        
        apply(snapshot, animatingDifferences: false)
    }
}
