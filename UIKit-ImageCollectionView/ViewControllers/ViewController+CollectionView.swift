//
//  ViewController+CollectionView.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/18/24.
//

import UIKit

// MARK: - DataSource
extension ViewController {
    
    func setupCollectionView() {
        // layout
        let collectionViewLayout = generateCompositionLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // delegate and dataSource
        collectionView.delegate = self
        configureDataSource()
    }
    
    func generateCompositionLayout() -> UICollectionViewLayout {
        /// Each row has four square cells.
        
        let fraction: CGFloat = 1/4
        
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func configureDataSource() {
        
        // create a DataSource
        self.dataSource = CollectionViewDataSource(collectionView: self.collectionView,
                                                   cellProvider: { collectionView, indexPath, itemIdentifier in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell.self)", for: indexPath) as? CollectionViewCell
            else {
                fatalError("Cannot create a cell for UICollectionView")
            }
            
            cell.configure(photo: itemIdentifier)
            
            return cell
        })
        
        // set a data source for the collectionView
        self.collectionView.dataSource = self.dataSource
        self.dataSource.updateSnapshot(dataList: photoList)
    }
}

// MARK: - Delegate

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
}
