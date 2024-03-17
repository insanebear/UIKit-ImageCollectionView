//
//  ViewController.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var collectionView: UICollectionView!
    var dataSource: DataSource!
    let dataList: [Int] = {
        return (1...100).map { $0 }
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupCollectionViewUI()
        
        configureDataSource()
    }
    
    private func setupCollectionViewUI() {
        let collectionViewLayout = generateCompositionLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func generateCompositionLayout() -> UICollectionViewLayout {
        /// Each row has four square cells.
        
        let fraction: CGFloat = 1/4
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
// MARK: - DataSource
extension ViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Int>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Int>
    
    func configureDataSource() {
        // register a cell for the collection view
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "\(CollectionViewCell.self)")
        
        // create a DataSource
        self.dataSource = DataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell.self)", for: indexPath) as? CollectionViewCell else {
                fatalError("Cannot create a cell for UICollectionView")
            }
            
            cell.configure(text: "\(itemIdentifier)")
            
            return cell
        })
        
        // set a data source for the collectionView
        self.collectionView.dataSource = self.dataSource
        updateSnapshot()
        
    }
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(dataList)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
