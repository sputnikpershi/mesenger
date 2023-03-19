//
//  FeedViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//
import SnapKit
import UIKit


class HomeViewController: UICollectionViewController {
    
    
    lazy var menuBar : MenuBar = {
        let menu = MenuBar()
        menu.homeVC = self
        return menu
    }()
    
    
    lazy var friendsBar : FriendsBar = {
        let menu = FriendsBar()
        menu.homeVC = self
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.register(HomeCollectionCell.self, forCellWithReuseIdentifier: "cID")
        collectionView.contentInset = UIEdgeInsets(top: 130, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 130, left: 0, bottom: 0, right: 0)
        collectionView.isPagingEnabled = true
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        let navTitleLabel = UILabel()
        navTitleLabel.text  = "Главная"
        navTitleLabel.font = UIFont(name: "Inter-SemiBold", size: 18)
        navTitleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 50, height: view.frame.height)
        navigationItem.titleView = navTitleLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tapButtonAction))
        
                navigationController?.hidesBarsOnSwipe = true
        setupMenuBar()
    }
    
   
    
    @objc func tapButtonAction () {
    }
    
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        menuBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        view.addSubview(friendsBar)
        friendsBar.snp.makeConstraints { make in
            make.top.equalTo(menuBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cID", for: indexPath) as! HomeCollectionCell
        cell.homeVC = self
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 310)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = Int(Float(targetContentOffset.pointee.x)/Float(scrollView.frame.size.width))
        menuBar.collectionView.selectItem(at: IndexPath(row: x, section: 0), animated: true, scrollPosition: .left)
        
        
    }
    //
    func scrollToMenuIndex (menuIndex: Int) {
        collectionView.scrollToItem(at: IndexPath(row: menuIndex, section: 0), at: .left , animated: true)
    }
    
   
    
    
}
