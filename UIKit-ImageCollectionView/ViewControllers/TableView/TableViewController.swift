//
//  TableViewController.swift
//  UIKit-ImageCollectionView
//
//  Created by Yurim Jayde Jeong on 3/19/24.
//

import UIKit
import Combine

class TableViewController: UIViewController {
    var tableView: UITableView!
    var dataSource: TableViewDataSource!
    
    var cancellables = Set<AnyCancellable>()
    var photoViewModel = PhotoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .backgroundColor
        
        setupTableView()
        setViewModel()
        
        photoViewModel.requestData(numOfPhotos: 100)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // remove "Back" string in the backButton
        self.tabBarController?.navigationItem.backButtonTitle = ""
        
        // deselect row
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

// MARK: - Delegate

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photoViewModel.photoList[indexPath.row]
        let vc = DetailViewController()
        vc.configure(photo: photo)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
