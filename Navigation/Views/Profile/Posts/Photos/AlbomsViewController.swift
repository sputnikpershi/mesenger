//
//  AlbomsViewController.swift
//  Navigation
//
//  Created by Kiryl Rakk on 2/3/23.
//

import UIKit
import SnapKit

class AlbomsViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "albom cell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "all photos")
        table.rowHeight = UITableView.automaticDimension
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayers()
        title = "Alboms"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAlbomAction))
    }
    
    private func setLayers() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func addAlbomAction() {
        print("add")
    }
}

extension AlbomsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "albom cell", for: indexPath) as! AlbomsTableViewCell
//
//            return cell
//        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "all photos", for: indexPath) as! AllPhotosTableViewCell
            
            return cell
//        }
        
    }
}
