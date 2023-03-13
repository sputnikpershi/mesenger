//
//  AllPhotosTableViewCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 2/3/23.
//

import UIKit
import SnapKit

class AllPhotosTableViewCell: UITableViewCell {
    var numberItems  = 4
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset =  UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
    

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(AlbomCell.self, forCellWithReuseIdentifier: "cell")
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()

    private lazy var albomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-SemiBold", size: 14)
        label.text = "Альбомы"
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var numbersLabel: UILabel = {
        let num = UILabel()
        num.font = UIFont(name: "Inter-SemiBold", size: 14)
        num.text = "1"
        return num
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(albomLabel)
        albomLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(16)
            
        }
        
        self.addSubview(numbersLabel)
        numbersLabel.snp.makeConstraints { make in
            make.leading.equalTo(albomLabel.snp.trailing).offset(10)
            make.top.equalTo(self.albomLabel.snp.top)
            
        }
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(albomLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
          
                make.height.equalTo((Int(numberItems/3)) * 100 + 100)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


extension AllPhotosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbomCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets  = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = CGFloat(4)
        let width = collectionView.bounds.width - (Constants.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
        let itemWidth = width / Constants.numberOfItemsInLine
//        let height = itemWidth
        return CGSize(width: itemWidth, height: 80)
    }
    
}
