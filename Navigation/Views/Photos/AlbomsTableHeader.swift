//
//  AlbomsTableViewCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 2/3/23.
//

import UIKit
import SnapKit

class AlbomsTableHeader: UITableViewHeaderFooterView {
    
    var numberItems = 1
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset =  UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 16)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(AlbomCell.self, forCellWithReuseIdentifier: "cell")
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var separatorHorizontal : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        return line
    } ()
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
        return num
    }()
    
    private lazy var showAll: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
        button.setTitle("Показать все", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayers() {
        
        self.addSubview(albomLabel)
        albomLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(4)
            
        }
        
        self.addSubview(numbersLabel)
        numbersLabel.snp.makeConstraints { make in
            make.leading.equalTo(albomLabel.snp.trailing).offset(10)
            make.top.equalTo(self.albomLabel.snp.top)
            
        }
        
        self.addSubview(showAll)
        showAll.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(albomLabel.snp.centerY)
            
        }
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.albomLabel.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        
        self.addSubview(separatorHorizontal)
        separatorHorizontal.snp.makeConstraints { make in
            make.top.equalTo(self.collectionView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(0.5)
        }
    }
}


extension AlbomsTableHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbomCell
        cell.setCell(index: indexPath.row + 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 80)
    }
    
}
