//
//  PostViewController.swift
//  Navigation
//
//  Created by Kiryl Rakk on 14/3/23.
//

import UIKit
import SnapKit

class PostViewController: UIViewController {
//    let drawerVC = DrawerView()
    var isExtended = false
    var viewModel : ProfileViewModel
    var indexPost: Int
    weak var profileVC : ProfileViewController?
    var post : AccountPosts
    var isHomeVC = false


    private lazy var drawerVC : DrawerView = {
        let view = DrawerView()
        view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height/2)
        view.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(DragedViewAction ))
        view.addGestureRecognizer(panGesture)
        return view
    }()
    private lazy var backButton : UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "arrow1"), for: .normal)
        button.tintColor = .orange
        return button
    }()
    
    private lazy var separator : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        return line
    } ()
    
    private lazy var moreImageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menu1"), for: .normal)
        button.isUserInteractionEnabled = true
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(tapedMoreActionButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.minimumLineSpacing = 4
        layout.sectionInset =  UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
//        layout.estimatedItemSize = CGSize(width: view.frame.width, height: 1)
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(PostCommentsCell.self, forCellWithReuseIdentifier: "cID")
        //        collection.register(PhotosView.self, forCellWithReuseIdentifier: "cpID")
        collection.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        collection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)

        collection.register(PostHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PostHeader.identifier)
        return collection
    }()
    
    private lazy var commentBackView: UIView = {
        let view = UIView ()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private lazy var addCommentButton: UIButton = {
        let button = UIButton ()
        button.setTitle("  оставить комментарии", for: .normal)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "paperclip"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 12)
        button.setTitleColor( UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1), for: .normal)
        return button
    }()

    init(viewModel: ProfileViewModel, indexPost: Int, post: AccountPosts) {
        self.viewModel = viewModel
        self.indexPost = indexPost
        self.post = post
        super.init(nibName: nil, bundle: nil)
        print(indexPost)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayers()
        setNavigation ()
        title = "Публикация"
    }
    
    private func setNavigation () {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow1"), style: .plain, target: self, action: #selector(tapedBackActionButton))
        let button = UIBarButtonItem(image: UIImage(named: "menu1"), style: .plain, target: self, action: #selector(tapedMoreActionButton))
        button.width = 6
        self.navigationItem.rightBarButtonItem = button
    }
    private func setLayers() {
        self.view.addSubview(drawerVC)
        self.view.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(29)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(0.5)
        }

        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.view.addSubview(commentBackView)
        commentBackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.view.addSubview(addCommentButton)
        addCommentButton.snp.makeConstraints { make in
            make.centerY.equalTo(commentBackView.snp.centerY)
            make.leading.equalTo(commentBackView.snp.leading).offset(16)
        }
    }
    
    @objc func tapedMoreActionButton () {
        print("more")
        drawerVC.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height/2)
        self.view.addSubview(drawerVC)
        if isExtended {
            UIView.animate(withDuration: 0.5) {
                self.drawerVC.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height/2)
                self.drawerVC.layer.cornerRadius = 0
            }
            isExtended = false
        } else if isExtended == false {

            UIView.animate(withDuration: 0.5) {
                self.drawerVC.frame = CGRect(x: 0, y: self.view.frame.height/2, width: self.view.frame.width, height: self.view.frame.height/2)
                self.drawerVC.layer.cornerRadius = 20
            }
            isExtended = true
            }
    }
    
    @objc func tapedBackActionButton () {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func DragedViewAction () {
        self.drawerVC.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height/2)
        self.isExtended = false
    }
    
    
    
}




extension PostViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PostHeader.identifier, for: indexPath) as? PostHeader else {
                return UICollectionReusableView()
            }
            header.setPost(post: post, account: viewModel.account)
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        // Use this view to calculate the optimal size based on the collection view's width
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required, // Width is fixed
                                                  verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        post.comments.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cID", for: indexPath) as! PostCommentsCell
        let post = post
        let account  = viewModel.findAccountWithPost(post: post)
        cell.setCell(comment: self.post.comments[indexPath.row], postIndex: indexPost , account: account)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return CGSize(width: width - 16, height: 68)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            let vc = AlbomsViewController()
//            navigationController?.pushViewController(vc, animated: true)
//        } else {
//            let vc = PostViewController()
//            navigationController?.pushViewController(vc, animated: true)
//
//        }
//    }
    
//    override func systemLayoutFittingSizeDidChange(forChildContentContainer container: UIContentContainer) {
//        width.constant = bounds.size.width
//        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
//    }
    
}



