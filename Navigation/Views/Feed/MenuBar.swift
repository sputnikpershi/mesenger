//
//  MenuBar.swift
//  Navigation
//
//  Created by Kiryl Rakk on 3/3/23.
//

import UIKit
import SnapKit



class MenuBar: UIView  {
    var homeVC: HomeViewController?
    
     lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(MenuCell.self, forCellWithReuseIdentifier: "cID")
        collection.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cID", for: indexPath) as! MenuCell
        if cell.isSelected {
            cell.indocatorLine.alpha = 1
            cell.titleLabel.textColor = .black
        } else {
            cell.indocatorLine.alpha = 0
            cell.titleLabel.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        }
       
        cell.setLabels(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/3, height: frame.height)
    }
//
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("---- indexPath in row : \(indexPath.row)")
        homeVC?.scrollToMenuIndex(menuIndex: indexPath.row)
    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! MenuCell
//        cell.titleLabel.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
//        cell.indocatorLine.alpha = 0
//
//    }
    
}
