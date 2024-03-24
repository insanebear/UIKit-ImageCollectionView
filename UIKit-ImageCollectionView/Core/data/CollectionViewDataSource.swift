//
//  CollectionViewDataSource.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import UIKit

class CollectionViewDataSource: UICollectionViewDiffableDataSource<Int, Photo> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Photo>
    
    private let cellProvider: (UICollectionView, IndexPath, Photo) -> UICollectionViewCell?

    override init(collectionView: UICollectionView, cellProvider: @escaping (UICollectionView, IndexPath, Photo) -> UICollectionViewCell?) {
        self.cellProvider = cellProvider
        
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            cellProvider(collectionView, indexPath, itemIdentifier)
        }
        
        // register a cell for the collection view
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "\(CollectionViewCell.self)")
    }

    
    func updateSnapshot(dataList: [Photo]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(dataList)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            apply(snapshot, animatingDifferences: false)
        }
    }
}
