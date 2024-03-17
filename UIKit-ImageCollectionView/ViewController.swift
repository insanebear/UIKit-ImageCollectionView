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
    var dataSource: CollectionViewDataSource!
    
    var photoList: [Photo] = [] {
        didSet {
            self.dataSource.updateSnapshot(dataList: photoList)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupCollectionViewUI()
        
        configureDataSource()
        
        requestData()
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

extension ViewController {
    func requestData() {
        let rm = RequestManager.shared
        let listPhotosParam = ListPhotos(page: 1, perPage: 10, orderBy: .latest)
        let request = ListPhotosRequest(parameters: listPhotosParam)
        
        Task {
            do {
                let response = try await rm.perform(request)
                photoList = response // update the list of Photos
            } catch (let error) {
                debugPrint(error)
            }
        }
    }
}
