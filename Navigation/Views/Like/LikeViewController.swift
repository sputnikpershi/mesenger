//
//  LikeVController.swift
//  Navigation
//
//  Created by Kiryl Rakk on 26/3/23.
//

import UIKit
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
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(LikeVCell.self, forCellWithReuseIdentifier: "cell")
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResultController.delegate = self
        
        setLayers()
        setNavigationController ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? fetchResultController.performFetch()
        DispatchQueue.main.async {
            print("reloaded Like VC")
            self.collectionView.reloadData()
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
                    _ = coreDataManager.getFilteredPostsData(authorLabel: searchText)
                    predicate = NSPredicate(format: "descriptionPost contains[cd] %@", searchText)
                } else {
                    predicate = nil
                }
            }
            
            fetchResultController.fetchRequest.predicate = predicate
            do {
                try fetchResultController.performFetch()
                collectionView.reloadData()
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
            collectionView.reloadData()
        } catch let err {
            print(err)
        }
    }
    private func setLayers() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension LikeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LikeVCell
        let posts = fetchResultController.fetchedObjects
        cell.index = indexPath.row
        cell.setup(with: posts ?? [], index: indexPath.row, account: profileMary.account)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    
}

extension LikeViewController: MyCellDelegate {
    func reloadData() {
        self.collectionView.reloadData()
    }
}


extension LikeViewController : NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            self.collectionView.deleteItems(at: [indexPath!])
        case .insert:
            self.collectionView.insertItems(at: [newIndexPath!])
        case .move:
            self.collectionView.moveItem(at: indexPath!, to: newIndexPath!)
        case .update:
            self.collectionView.reloadItems(at: [indexPath!])
        @unknown default:
            self.collectionView.reloadData()
        }
    }
}
