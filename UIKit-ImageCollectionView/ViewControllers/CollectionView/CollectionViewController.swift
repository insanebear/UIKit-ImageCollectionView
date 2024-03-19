//
//  CollectionViewController.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import UIKit
import SnapKit

class CollectionViewController: UIViewController {
    var collectionView: UICollectionView!
    var dataSource: CollectionViewDataSource!
    
    var photoList: [Photo] = [] {
        didSet {
            self.dataSource.updateSnapshot(dataList: photoList)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        
        setupCollectionView()
        requestData(numOfPhotos: 100)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // remove "Back" string in the backButton
        self.tabBarController?.navigationItem.backButtonTitle = ""
    }
}

extension CollectionViewController {
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
