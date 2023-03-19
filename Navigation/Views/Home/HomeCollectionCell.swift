//
//  HomeCollectionCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 6/3/23.
//

import UIKit
import SnapKit

class HomeCollectionCell: UICollectionViewCell {
    
    var homeVC : HomeViewController?
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(MainPostsCell.self, forCellWithReuseIdentifier: "cID")
        collection.register(FilteredPostsCell.self, forCellWithReuseIdentifier: "fcID")

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
             maryAccount.posts.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cID", for: indexPath) as! MainPostsCell
            cell.setup(with: maryAccount.posts, index: indexPath.row)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fcID", for: indexPath) as! FilteredPostsCell
            cell.setup(with: maryAccount.posts, index: indexPath.row)
            return cell
        }
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: frame.width, height: 400)
        }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = PostViewController()
         homeVC?.navigationController?.pushViewController(vc, animated: true)
         
        print("selected")
    }
    
}
