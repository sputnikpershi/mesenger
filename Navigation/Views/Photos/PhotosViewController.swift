//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 8/18/22.
//

import UIKit

class PhotosViewController: UIViewController {
    
    
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
    }
    
    private func setNavigationBar () {
        self.navigationController?.navigationBar.isHidden = false
        let localizationText = NSLocalizedString("gallery-title", comment: "")
        self.navigationItem.title = localizationText
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

    // MARK: EXTENSION

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            cell.backgroundColor = .green
            return cell
        }
        cell.backgroundColor = .brown
        cell.setup(with: photosArray, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets  = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0
        let width = collectionView.bounds.width - (Constants.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
        let itemWidth = width / Constants.numberOfItemsInLine
        let height = itemWidth
        return CGSize(width: itemWidth, height: height)
    }
}


