//
//  TableViewController.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/19/24.
//

import UIKit

class TableViewController: UIViewController {
    var tableView: UITableView!
    var dataSource: TableViewDataSource!
    
    var photoList: [Photo] = [] {
        didSet {
            self.dataSource.updateSnapshot(dataList: photoList)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .backgroundColor
        
        setupTableView()
        requestData(numOfPhotos: 100)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .backgroundColor
        tableView.rowHeight = Device.width / 5
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // delegate and dataSource
        tableView.delegate = self
        configureDataSource()
    }
    
    private func configureDataSource() {
        // create a DataSource
        self.dataSource = TableViewDataSource(tableView: self.tableView,
                                              cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TableViewCell.self)", for: indexPath) as? TableViewCell else {
                fatalError("Cannot create a cell for UITableView")
            }
            
            cell.configure(photo: itemIdentifier)
            
            return cell
        })
        
        // set a data source for the tableView
        self.tableView.dataSource = self.dataSource
        self.dataSource.updateSnapshot(dataList: photoList)
    }
    
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

// MARK: - Delegate

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photoList[indexPath.row]
        let vc = DetailViewController()
        vc.configure(photo: photo)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
