//
//  HomeCollectionCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 6/3/23.
//

import UIKit
import SnapKit

class HomeCollectionCell: UICollectionViewCell {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cID")
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayers() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
             postArray.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cID", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: frame.width, height: 200)
        }
    
    
}
