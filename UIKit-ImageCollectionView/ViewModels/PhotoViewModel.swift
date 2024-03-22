//
//  PhotoViewModel.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/22/24.
//

import Foundation

class PhotoViewModel {
    @Published var photoList: [Photo] = []
    
    func requestData(numOfPhotos: Int = 10) {
        /// Unsplash API provides maxium 30 photos at a request. (`perPage`)
        let rm = RequestManager.shared

        Task {
            var perPage = numOfPhotos > 30 ? 30 : numOfPhotos
            var currentPage = 1
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
    
//    func requestData(numOfPhotos: Int = 10) {
//        /// Unsplash API provides maxium 30 photos at a request. (`perPage`)
//        let rm = RequestManager.shared
//
//        Task {
//            do {
//                // Repeat requests until photoList contains the desired number of photos.
//                let listPhotosParam = ListPhotos(page: 1, perPage: 30, orderBy: .latest)
//                let request = ListPhotosRequest(parameters: listPhotosParam)
//
//                let photos = try await rm.perform(request)
//                photoList.append(contentsOf: photos) // append the list of Photos
//
//            } catch (let error) {
//                debugPrint(error)
//            }
//        }
//    }
}
