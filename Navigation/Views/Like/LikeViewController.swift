//
//  LikeViewController.swift
//  Navigation
//
//  Created by Kiryl Rakk on 2/12/22.
//

import UIKit
import SnapKit
import CoreData

protocol MyCellDelegate: AnyObject {
    func reloadData()
}

class LikeViewController: UIViewController {
    var index  = 0
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    var isLiked  = false
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    private lazy var tableView: UITableView = {
        let table = UITableView (frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 140
        table.register(LIkeTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Likes"
        setLayers()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
  
    @objc func loadList(notification: NSNotification){
        self.tableView.reloadData()
    }
    
    private func setLayers() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension LikeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coreDataManager.posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! LIkeTableViewCell
        cell.contentView.isUserInteractionEnabled = false
        cell.delegate = self
        cell.index = indexPath.row
        cell.setup(with:coreDataManager.posts, index: indexPath.row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension LikeViewController: MyCellDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
}
