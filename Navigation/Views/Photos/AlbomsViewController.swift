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
        table.register(AllPhotosTableViewCell.self, forCellReuseIdentifier: "all photos")
        table.register(AlbomsTableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight  = 400
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        return table
    }()
    private lazy var separatorHorizontal : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        return line
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayers()
        title = "Alboms"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAlbomAction))
    }
    
    private func setLayers() {
        self.view.addSubview(separatorHorizontal)
        separatorHorizontal.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(0.5)
        }
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.separatorHorizontal.snp.bottom)
        }
        
    }
    
    @objc private func addAlbomAction() {
        print("add")
    }
}

extension AlbomsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! AlbomsTableHeader
        return header
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "all photos", for: indexPath) as! AllPhotosTableViewCell
            return cell
        
    }
}
