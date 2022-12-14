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
    var postsData = [PostData]()

    private lazy var fetchResultController: NSFetchedResultsController = {
        let fetchRequest = PostData.fetchRequest()
        fetchRequest.sortDescriptors = []
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
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
        self.postsData = coreDataManager.posts
        setNavigationController ()
        setLayers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
                self.postsData = self.coreDataManager.posts
                print("reloaded Like VC")
                self.tableView.reloadData()
            }
    }
 
  
    private func setNavigationController () {
            let filterButton =  UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(filteAction))
            let setDefaultButton = UIBarButtonItem(image: UIImage(systemName: "xmark.seal"), style: .plain, target: self, action: #selector(cleanFilterAction))
            self.navigationItem.rightBarButtonItems = [setDefaultButton, filterButton]
        }
    @objc func filteAction() {
            let alertController = UIAlertController(title: "Author Filter", message: "Please enter the name of author in the field below to show you all his posts", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter name"
            }
       
            let saveAction = UIAlertAction(title: "save", style: .default, handler: { alert -> Void in
                   if let textField = alertController.textFields?[0] {
                       if textField.text!.count > 0 {
                           print("Text :: \(textField.text ?? "")")
                           let author = textField.text
                         self.postsData = self.coreDataManager.getFilteredPostsData(authorLabel: author) ?? []
                           DispatchQueue.main.async {
                               self.tableView.reloadData()
                           }
                       }
                   }
               })
            
            let cancelAction = UIAlertAction(title: "cancel", style: .destructive, handler: {
                   (action : UIAlertAction!) -> Void in })
               alertController.addAction(cancelAction)
               alertController.addAction(saveAction)
               alertController.preferredAction = saveAction
               self.present(alertController, animated: true, completion: nil)
           
        }
        
        @objc func cleanFilterAction() {
            DispatchQueue.main.async {
              self.postsData = self.coreDataManager.getFilteredPostsData() ?? []
                self.tableView.reloadData()
            }
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
        postsData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! LIkeTableViewCell
        cell.contentView.isUserInteractionEnabled = false
        cell.delegate = self
        cell.index = indexPath.row
        cell.setup(with:postsData, index: indexPath.row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension LikeViewController: MyCellDelegate {
    func reloadData() {
        self.postsData = coreDataManager.posts
        self.tableView.reloadData()
    }
}


extension LikeViewController : NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        
    }
}
