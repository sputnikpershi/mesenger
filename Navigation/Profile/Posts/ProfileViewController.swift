//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var tableView: UITableView  = {
        let table = UITableView (frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 140
        table.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
        table.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    } ()
    
    private lazy var profileHeaderView : ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light }
        self.view.backgroundColor = .secondarySystemBackground
        
        self.tabBarController?.tabBar.backgroundColor = .secondarySystemBackground
        setViews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setViews() {
        self.view.addSubview(self.tableView)
    }
    
    private func setConstraints () {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileTableHeaderView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "Вы несете ответсвенность за каждое слово в публичном пространстве."
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == .zero {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
            cell.setup(with: photosArray)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PostTableViewCell
            cell.setup(with: postArray, index: indexPath.row)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = PhotosViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
