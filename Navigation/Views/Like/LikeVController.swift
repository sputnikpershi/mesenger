//
//  LikeVController.swift
//  Navigation
//
//  Created by Kiryl Rakk on 26/3/23.
//

import UIKit
import CoreData

 


class LikeVController: UIViewController {
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
        
    }
    @objc func cleanFilterAction() {
        
    }
        private func setLayers() {
            self.view.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }


extension LikeVController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LikeVCell
                let posts = fetchResultController.fetchedObjects
        print(posts?.count)
        cell.index = indexPath.row
//        cell.postArray = view
        cell.setup(with: posts ?? [], index: indexPath.row, account: profileMary.account)
//        cell.setup(with: <#T##[AccountPosts]#>, index: <#T##Int#>, account: <#T##Account?#>)
//        cell.contentView.isUserInteractionEnabled = false
//        let post = fetchResultController.object(at: indexPath)
//        cell.delegate = self
//        cell.index = indexPath.row
//        cell.indexPath = indexPath
//        cell.setup(with: post)
//        cell.post = post
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    
}

extension LikeVController: MyCellDelegate {
    func reloadData() {
        self.collectionView.reloadData()
    }
}


extension LikeVController : NSFetchedResultsControllerDelegate {
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
