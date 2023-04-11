//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//
import UIKit
import CoreData
import SnapKit
import UniformTypeIdentifiers

class ProfileViewController: UIViewController {
    
    var coordinator : ProfileTabCoordinator?
    private var initialAvatarFrame = CGRect(x: 26, y: 16, width: 60, height: 60)
    private var viewModel : ProfileViewModel?
    var postData = [PostData]()
    var originIndex = Int()
    var popupMenu = PopupMenu()
    var sideMenu = UIView()
    var isMainProfile: Bool?
    var moreInfoActionState : SideMenuState = .closed
    var menuActionState : SideMenuState = .closed
    var accountPosts: [AccountPosts]?
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    var isSearched = false 

    
    private lazy var fetchResultController: NSFetchedResultsController = {
        let fetchRequest = PostData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "authorLabel", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    
    private lazy var blackView : UIView = {
        let view = UIView()
        view.alpha = 0
        view.tag = 99
        view.backgroundColor = colorBlackView
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapedBlackViewAction)))
        return view
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(MainPostsCell.self, forCellWithReuseIdentifier: "cID")
        return collection
    }()
    
    private lazy var avaImage: UIImageView = {
        let image = UIImageView()
        image.alpha = 0
        //        image.image = UIImage(named: viewModel?.account.avatar!)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        image.layer.cornerRadius = self.initialAvatarFrame.height/2
        return image
    }()
    
    private lazy var backgroundView: UIView = {
        let background = UIView()
        background.backgroundColor = .black
        background.alpha = 0
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    } ()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemYellow
        button.alpha = 0
        button.clipsToBounds = true
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.layer.masksToBounds = true
        button.setImage(UIImage(systemName: "clear.fill"), for: .normal)
        button.addTarget(self, action: #selector(self.closeAvatarImage), for: .touchUpInside)
        return button
    }()
    
    private var avatarWidthConstant : NSLayoutConstraint?
    private var avatarHeightConstant : NSLayoutConstraint?
    private var avatarLeadingConstant :NSLayoutConstraint?
    private var avatarTopConstant :NSLayoutConstraint?
    
    // MARK: INIT
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountPosts = viewModel?.returnAccountPosts() ?? []
        self.view.backgroundColor = .secondarySystemBackground
        self.tabBarController?.tabBar.backgroundColor = .secondarySystemBackground
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        setNavigation()
        setViews()
        setConstraints()
        
        if isMainProfile! {
            collectionView.register(ProfileHeaderCollection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderCollection.identifier)
        } else {
            collectionView.register(FriendProfileHeaderCollection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FriendProfileHeaderCollection.identifier)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu2"), style: .plain, target: self, action: #selector(tapedRightMenuActionButton))
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.isHidden = false
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @objc func loadList(notification: NSNotification){
        self.blackView.alpha = 0
        moreInfoActionState = .closed
        menuActionState = .closed
    }
    
    private func setNavigation() {
        let titleView = UILabel()
        titleView.text = viewModel?.account.nickname
        titleView.textColor = UIColor.createColor(lightMode: .black, darkMode: .orange)
        titleView.font = UIFont(name: "Inter-Medium", size: 16)
        titleView.frame = CGRect(x: 0, y: 0, width: view.frame.width - 50, height: view.frame.height)
        navigationItem.titleView = titleView
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func tapedRightMenuActionButton() {
        tapMenu()
    }
    
    func setMenu () {
        popupMenu.view = self
        popupMenu.showSettings()
    }
    
    private func setViews() {
        self.view.addSubview(self.collectionView)
        self.view.addSubview(blackView)
    }
    
    private func setConstraints () {
        collectionView.snp.makeConstraints{ make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        blackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func animateAvatar (ava: UIImageView) {
        
        //  MARK: Keyframe Animation
        
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.initialAvatarFrame = ava.frame
                self.avatarWidthConstant?.constant = self.view.frame.width
                self.avatarHeightConstant?.constant = self.view.frame.width
                self.avatarLeadingConstant?.constant = 0
                self.avatarTopConstant?.constant = self.view.frame.width/3
                self.avaImage.layer.cornerRadius = 0
                self.avaImage.alpha = 1
                self.backgroundView.alpha = 0.75
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.8) {
                self.backButton.alpha = 1
            }
        } completion: { _ in
            
        }
    }
    
    @objc func closeAvatarImage () {
        self.avatarWidthConstant?.constant = self.initialAvatarFrame.width
        self.avatarHeightConstant?.constant = self.initialAvatarFrame.height
        self.avatarLeadingConstant?.constant = self.initialAvatarFrame.minX
        self.avatarTopConstant?.constant = self.initialAvatarFrame.minY
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.avaImage.layer.cornerRadius = self.initialAvatarFrame.height/2
            self.avaImage.alpha = 0
            self.backgroundView.alpha = 0
            self.backButton.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
        }
    }
    
    func tapEditButton() {
        let vc = EditMenuViewController()
        vc.isFemale = viewModel?.account.sex
        vc.account = viewModel?.account
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func tapInfo () {
        if moreInfoActionState == .closed {
            createSideMenu(state: .moreInfoAction)
            moreInfoActionState = .opened
        } else {
            removeSideMenu()
            moreInfoActionState = .closed
        }
    }
    
    @objc private func tapedBlackViewAction() {
        removeSideMenu ()
        self.moreInfoActionState = .closed
        self.menuActionState = .closed
        
    }
    
    func tapMenu () {
        if menuActionState == .closed && moreInfoActionState == .opened {
            removeSideMenu ()
            moreInfoActionState = .closed
        } else if menuActionState == .closed {
            createSideMenu (state: .menuAction)
            menuActionState = .opened
        } else {
            removeSideMenu()
            menuActionState = .closed
        }
    }
    
    func createSideMenu (state: StateMenu) {
        let title = (viewModel?.account.name ?? "") + " " + (viewModel?.account.surname ?? "")
        let menu = SideMenuView(state: state, title:  title)
        menu.viewWithTag(100)
        menu.view = self
        sideMenu = menu
        self.sideMenu.frame = CGRect(x: self.view.frame.width, y: 0, width: 300, height: self.view.frame.height)
        self.navigationController?.view.addSubview(sideMenu)
        UIView.animate(withDuration: 0.4, delay: 0) {
            self.sideMenu.frame = CGRect(x: self.view.frame.width - 300, y: 0, width: 300, height: self.view.frame.height)
            self.blackView.alpha = 0.3
        }
    }
    func removeSideMenu () {
        UIView.animate(withDuration: 0.4, delay: 0) {
            self.blackView.alpha = 0
            self.sideMenu.frame = CGRect(x: self.view.frame.width, y: 0, width: 300, height: self.view.frame.height)
        }
    }
    
    // MARK: EXTENSION
     func searchPost() {
         
         let alertController = UIAlertController(title: "Найти пост", message: "Введите слово по которому хотите найти пост", preferredStyle: .alert)
         alertController.addTextField { (textField : UITextField!) -> Void in
             textField.placeholder = "Enter name"
         }
         let saveAction = UIAlertAction(title: "save", style: .default, handler: { [weak self] alert -> Void in
             if let textField = alertController.textFields?[0] {
                
                 self?.accountPosts = self?.accountPosts?.filter({ post in
                     post.descriptionLabel.contains(textField.text ?? "" )
                 })
                 print(self?.accountPosts?.count)
                 self?.isSearched = true
                 self?.collectionView.reloadData()
             }
//             self?.accountPosts  = viewModel?.returnAccountPosts() ?? []
            })
         
         let cancelAction = UIAlertAction(title: "cancel", style: .destructive, handler: {
             (action : UIAlertAction!) -> Void in
             

         })
         if isSearched {
             let clearAction = UIAlertAction(title: "clear", style: .destructive) { action in
                 self.accountPosts  = self.viewModel?.returnAccountPosts() ?? []
                 self.collectionView.reloadData()

             }
             alertController.addAction(clearAction)

         }
         
         alertController.addAction(cancelAction)
         alertController.addAction(saveAction)

         alertController.preferredAction = saveAction
         self.present(alertController, animated: true, completion: nil)
     }
}


// MARK: EXTENSION

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if isMainProfile! {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeaderCollection.identifier, for: indexPath) as? ProfileHeaderCollection else {
                    return UICollectionReusableView()
                }
                header.setup(user: (viewModel?.account)!)
                header.profileVC = self
                header.viewModel = viewModel
                return header
            } else {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FriendProfileHeaderCollection.identifier, for: indexPath) as? FriendProfileHeaderCollection else {
                    return UICollectionReusableView()
                }
                header.setup(friends: (viewModel?.friends)!)
                header.profileVC = self
                header.viewModel = viewModel
                return header
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if isMainProfile!{
            return (CGSize(width: collectionView.frame.width, height: 500))
        } else {
            return (CGSize(width: collectionView.frame.width, height: 440))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        accountPosts?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cID", for: indexPath) as! MainPostsCell
        cell.profileVC = self
//        let posts = viewModel?.returnAccountPosts() ?? []
        cell.postArray = accountPosts
        cell.index = indexPath.row
        cell.setup(with: accountPosts ?? [], index: indexPath.row, account: viewModel?.account)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PostViewController(viewModel: viewModel!, indexPost: indexPath.row, post: (viewModel?.returnAccountPosts()[indexPath.row])!)
        vc.profileVC = self
        vc.indexPost = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
        
    }
}


