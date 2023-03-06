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
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    var isLiked  = false
    
    private lazy var fetchResultController: NSFetchedResultsController = {
        let fetchRequest = PostData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "authorLabel", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView (frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 400
        table.register(LIkeTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchResultController.delegate = self
        let localizationText = NSLocalizedString("likes-title", comment: "")
        self.title = localizationText
        self.view.addSubview(tableView)
        setLayers()
        setNavigationController ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? fetchResultController.performFetch()
        
        DispatchQueue.main.async {
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
        
        
        let saveAction = UIAlertAction(title: "save", style: .default, handler: { [self] alert -> Void in
            var predicate: NSPredicate?
            if let textField = alertController.textFields?[0] {
                if let searchText = textField.text, searchText.count > 0 {
                    coreDataManager.getFilteredPostsData(authorLabel: searchText)
                    predicate = NSPredicate(format: "authorLabel contains[cd] %@", searchText)
                } else {
                    predicate = nil
                }
            }
            
            fetchResultController.fetchRequest.predicate = predicate
            do {
                try fetchResultController.performFetch()
                tableView.reloadData()
            } catch let err {
                print(err)
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
        self.fetchResultController.fetchRequest.predicate = nil
        do {
            try fetchResultController.performFetch()
            tableView.reloadData()
        } catch let err {
            print(err)
        }
    }
   
    private func setLayers() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension LikeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! LIkeTableViewCell
        cell.contentView.isUserInteractionEnabled = false
        let post = fetchResultController.object(at: indexPath)
        cell.delegate = self
        cell.index = indexPath.row
        cell.indexPath = indexPath
        cell.fetchResultController = fetchResultController
        cell.setup(with: post)
        cell.post = post
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


extension LikeViewController : NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .move:
            self.tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            self.tableView.reloadRows(at: [indexPath!], with: .automatic)
        @unknown default:
            self.tableView.reloadData()
        }
    }
}



//
//
//
//@objc func filteAction() {
//    let alertController = UIAlertController(title: "Author Filter", message: "Please enter the name of author in the field below to show you all his posts", preferredStyle: .alert)
//    alertController.addTextField { (textField : UITextField!) -> Void in
//        textField.placeholder = "Enter name"
//    }
//
//    let saveAction = UIAlertAction(title: "save", style: .default, handler: { [self] alert -> Void in
//        if let textField = alertController.textFields?[0] {
//            if textField.text!.count > 0 {
//                print("Text :: \(textField.text ?? "")")
//                let author = textField.text
//                self.postsData = self.coreDataManager.getFilteredPostsData(authorLabel: author) ?? []
//                print(self.postsData.first?.authorLabel)
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    })
