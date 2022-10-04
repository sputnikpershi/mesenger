//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 8/18/22.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private lazy var facade = ImagePublisherFacade()
    private lazy var arrayOfImage = [UIImage]()
    private lazy var profileImages = [UIImage]()
    
    private enum Constants {
        static let numberOfItemsInLine : CGFloat = 3
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset =  UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView (frame: .zero, collectionViewLayout: self.layout)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        return collection
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.setViews()
        self.setConstraints()
        self.setImages()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.facade.subscribe(self)  // Подписка на наблюдателя
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.facade.removeSubscription(for: self) // Удаление наблюдателя из подписки
    }
    

    private func setImages () {
        photoGallery.forEach { profileImages.append((UIImage(named: $0)!)) }
        facade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: profileImages)
    }
    
    private func setNavigationBar () {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Photo gallery"
    }
    
    
    private func setViews () {
        self.view.addSubview(self.collectionView)
    }
    
    
    private func setConstraints () {
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}


// MARK: EXTENSIONS


extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfImage.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            cell.backgroundColor = .green
            return cell
        }
        cell.backgroundColor = .brown
        //        cell.setup(with: photosArray, index: indexPath.row)
        cell.setup(with: arrayOfImage, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets  = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0
        let width = collectionView.bounds.width - (Constants.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
        let itemWidth = width / Constants.numberOfItemsInLine
        let height   = itemWidth
        print ("🤪  - Height: \(height)\n  - Width \(itemWidth)\n - Insets: \(insets)\n -  interItem: \(interItemSpacing)\n  \n")
        return CGSize(width: itemWidth, height: height)
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        arrayOfImage = images
        collectionView.reloadData()
    }
}
