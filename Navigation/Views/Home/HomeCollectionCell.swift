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
    var searchText: String? {
        didSet {
            
        }
    }
    var menuIndex: Int! {
        didSet {
            
        }
    }
    
    var posts: [AccountPosts] {
//        if menuIndex == 0 {
            return viewModel?.searchAccountPosts(searchText: searchText) ?? []
//        } else {
//            return viewModel?.returnFriendsPosts() ?? []
//        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.minimumLineSpacing = 0
        collection.dataSource = self
        collection.delegate = self
        collection.register(MainPostsCell.self, forCellWithReuseIdentifier: "cell")
//        collection.register(FilteredPostsCell.self, forCellWithReuseIdentifier: "fcID")
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayers()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    @objc func loadList(notification: NSNotification){
        self.collectionView.reloadData()
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
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainPostsCell
        cell.postArray = posts
        cell.homeVC = homeVC
        cell.index = indexPath.row
        cell.setup(with: posts, index: indexPath.row, account: viewModel?.account)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PostViewController(viewModel: ProfileViewModel(account: profileMary.account),  indexPost: indexPath.row, post: posts[indexPath.row])
        vc.isHomeVC = true
        homeVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeCollectionCell: SearchPostDelegate {
    func searchPost(text: String?) {
        //        posts = viewModel?.searchAccountPosts(searchText: text )
        print("213")
    }
}
