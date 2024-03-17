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
        
        requestData(numOfPhotos: 100)
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
    func requestData(numOfPhotos: Int = 10) {
        /// Unsplash API provides maxium 30 photos at a request. (`perPage`)
        let rm = RequestManager.shared
        var perPage = numOfPhotos > 30 ? 30 : numOfPhotos
        var currentPage = 1
        
        Task {
            while photoList.count < numOfPhotos {
                do {
                    // Repeat requests until photoList contains the desired number of photos.
                    let listPhotosParam = ListPhotos(page: currentPage, perPage: perPage, orderBy: .latest)
                    let request = ListPhotosRequest(parameters: listPhotosParam)
                    
                    let photos = try await rm.perform(request)
                    photoList.append(contentsOf: photos) // append the list of Photos
                    
                    currentPage += 1
                    
                    let leftover = numOfPhotos - photoList.count
                    perPage = leftover > 30 ? 30 : leftover
                    
                } catch (let error) {
                    debugPrint(error)
                }
            }
        }
    }
}
