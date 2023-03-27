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
    var viewModel : ProfileViewModel?
    var allPosts : [AccountPosts]?

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.minimumLineSpacing = 0
        collection.dataSource = self
        collection.delegate = self
        collection.register(MainPostsCell.self, forCellWithReuseIdentifier: "cID")
        collection.register(FilteredPostsCell.self, forCellWithReuseIdentifier: "fcID")

        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayers()
        
        allPosts = viewModel?.account.posts
        viewModel?.friends?.forEach({ friend in
            friend.account.posts.forEach { post in
                allPosts?.append(post)
            }
        })
        allPosts = allPosts?.sorted(by: { date1, date2 in
            date1.date > date2.date
        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewModel(viewModel: ProfileViewModel?){
        self.viewModel = viewModel
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
             allPosts?.count ?? 0
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cID", for: indexPath) as! MainPostsCell
            cell.postArray = viewModel?.account.posts            
//            viewModel?.account.posts[indexPath.row].authorLabel = (viewModel?.account.name)! +  " " + (viewModel?.account.surname)!
//            viewModel?.account.posts[indexPath.row].statusLabel = viewModel?.account.status
//            viewModel?.account.posts[indexPath.row].authorImage = viewModel?.account.avatar
            cell.setup(with: allPosts ?? [], index: indexPath.row, account: viewModel?.account)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fcID", for: indexPath) as! FilteredPostsCell
            cell.setup(with: viewModel?.account.posts ?? [], index: indexPath.row, account: viewModel?.account)
            return cell
        }
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: frame.width, height: 400)
        }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
         let vc = PostViewController(viewModel: ProfileViewModel(account: profileMary.account),  indexPost: indexPath.row)
         homeVC?.navigationController?.pushViewController(vc, animated: true)
         
        print("selected")
    }
    
}
