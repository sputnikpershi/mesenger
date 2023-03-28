//
//  PopupMenu.swift
//  Navigation
//
//  Created by Kiryl Rakk on 10/3/23.
//

import UIKit

class PopupMenu: NSObject {
    let blackView = UIView()
    var view : UIViewController?
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(PopupMenuCell.self, forCellWithReuseIdentifier: PopupMenuCell.identifier)
        return collection
    }()
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func showSettings () {
        blackView.backgroundColor = .black
        blackView.alpha = 0
        self.view?.view.addSubview(blackView)
        self.view?.view.addSubview(collectionView)
        collectionView.frame = CGRect(x: (self.view?.view.center.y)! - 300, y: (self.view?.view.center.y)!, width: 300, height: 250)
        blackView.frame = (self.view?.view.frame)!
       
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapedBlackViewAction)))
        
        UIView.animate(withDuration: 0.4, delay: 0) {
            self.blackView.alpha = 0.3
            self.collectionView.alpha = 1
        }
        
    }
    
    @objc private func tapedBlackViewAction() {
        UIView.animate(withDuration: 0.4, delay: 0) {
            self.blackView.alpha = 0
            self.collectionView.alpha = 0
            
        }    }
}

extension PopupMenu: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopupMenuCell.identifier, for: indexPath) as! PopupMenuCell
        cell.setCell(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 41)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapedBlackViewAction()
    }
}
