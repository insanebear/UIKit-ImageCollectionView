//
//  CollectionViewController.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/17/24.
//

import UIKit
import Combine

class CollectionViewController: UIViewController {
    var collectionView: UICollectionView!
    var dataSource: CollectionViewDataSource!
    
    var cancellables = Set<AnyCancellable>()
    var photoViewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        
        setupCollectionView()
        setViewModel()
        
        photoViewModel.requestData(numOfPhotos: 100)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // remove "Back" string in the backButton
        self.tabBarController?.navigationItem.backButtonTitle = ""
    }
    
    func setViewModel() {
        photoViewModel.$photoList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] photoList in
                self?.dataSource.updateSnapshot(dataList: photoList)
            }
            .store(in: &cancellables)
    }
}
