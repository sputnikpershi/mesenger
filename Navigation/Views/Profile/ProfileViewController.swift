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

    // MARK: INIT
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var blackView : UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .black
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapedBlackViewAction)))
        return view
    }()

    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(MainPostsCell.self, forCellWithReuseIdentifier: "cID")
        collection.register(ProfileHeaderCollection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderCollection.identifier)
        return collection
    }()
    
    private lazy var avaImage: UIImageView = {
        let image = UIImageView()
        image.alpha = 0
        image.image = viewModel?.user.image
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
    
//    private lazy var sideMenuView: SideMenuInfo = {
//        let view = SideMenuInfo(frame: CGRect(x: self.view.frame.width, y: 0, width: 300, height: self.view.frame.height))
//        return view
//    }()
    
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
    
    // MARK: VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        self.tabBarController?.tabBar.backgroundColor = .secondarySystemBackground
        setViews()
        setConstraints()
        setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu2"), style: .plain, target: self, action: #selector(tapedRightMenuActionButton))
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            print("reload ProfileVC")
        }
    }
    
    private func setNavigation() {
        let titleView = UILabel()
        titleView.text = maryAccount.nickname
        titleView.textColor = .black
        titleView.font = UIFont(name: "Inter-Medium", size: 16)
        titleView.frame = CGRect(x: 0, y: 0, width: view.frame.width - 50, height: view.frame.height)
        navigationItem.titleView = titleView
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func tapedRightMenuActionButton() {
        print("menu")
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
            make.top.equalToSuperview()
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
        vc.isFemale = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func logOutAction () {
        let userDefault = UserDefaults.standard
        print(" log out")
        let hasLogedIn = userDefault.bool(forKey: "hasLogedIn")    //    Singletone.shared.isFirstTime
        if  hasLogedIn {
            self.navigationController?.popToRootViewController(animated: true)
            userDefault.set(false, forKey: "hasLogedIn")
        } else {
            self.navigationController?.pushViewController(LogInViewController(), animated: true)
            userDefault.set(false, forKey: "hasLogedIn")
        }
    }
    
    func tapNEnu () {
        let menu = SideMenuView(state: .moreInfoAction)
        sideMenu = menu
        self.sideMenu.frame = CGRect(x: self.view.frame.width, y: 0, width: 300, height: self.view.frame.height)
        self.view.addSubview(sideMenu)
        UIView.animate(withDuration: 0.4, delay: 0) {
            self.sideMenu.frame = CGRect(x: self.view.frame.width - 300, y: 0, width: 300, height: self.view.frame.height)
            self.blackView.alpha = 0.3
        }
    }
    
    @objc private func tapedBlackViewAction() {
        UIView.animate(withDuration: 0.4, delay: 0) {
            self.blackView.alpha = 0
            self.sideMenu.frame = CGRect(x: self.view.frame.width, y: 0, width: 300, height: self.view.frame.height)
        }
    }
    
    func tapMenu () {
        let menu = SideMenuView(state: .menuAction)
        sideMenu = menu
        self.sideMenu.frame = CGRect(x: self.view.frame.width, y: 0, width: 300, height: self.view.frame.height)
        self.view.addSubview(sideMenu)
        UIView.animate(withDuration: 0.4, delay: 0) {
            self.sideMenu.frame = CGRect(x: self.view.frame.width - 300, y: 0, width: 300, height: self.view.frame.height)
            self.blackView.alpha = 0.3
        }
    }
}



extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeaderCollection.identifier, for: indexPath) as? ProfileHeaderCollection else {
                return UICollectionReusableView()
            }
            header.setup(user: maryAccount )
            header.profileVC = self
            return header
        }
        return UICollectionReusableView()

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 540)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        maryAccount.posts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.row == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cpID", for: indexPath) as! PhotosTableViewCell
//            cell.setup(with: photosArray)
//            cell.buttonTapCallback = {
//                print("123")
//            }
//            return cell
//        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cID", for: indexPath) as! MainPostsCell
            cell.profileVC = self
            cell.setup(with: maryAccount.posts, index: indexPath.row)
            return cell
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = PostViewController()
            navigationController?.pushViewController(vc, animated: true)
        print("selected")
    }
}





// MARK: EXTENSION
//
//extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileTableHeaderView
//        headerView?.profileVC = self
//        headerView?.setup(user: viewModel!.user)// Передача данных user в элементы ProfileTableHeaderView
//        return headerView
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        200
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        postArray.count + 1
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == .zero {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
//            cell.setup(with: photosArray)
//            cell.buttonTapCallback = {
//                print("COmething")
//            }
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PostTableViewCell
//            cell.index = indexPath.row - 1
//            cell.setup(with: postArray, index: indexPath.row - 1 )
//            cell.contentView.isUserInteractionEnabled = false
//            return cell
//        }
//    }
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            let vc = AlbomsViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//
//}
//
extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else
        { return lightMode }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
//
//
//extension ProfileViewController: UITableViewDragDelegate, UITableViewDropDelegate {
//
//    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
//        return session.canLoadObjects(ofClass: NSString.self) && session.canLoadObjects(ofClass: UIImage.self)
//    }
//
//    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
//        if tableView.hasActiveDrag {
//                    return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
//                } else {
//                    return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
//                }
//    }
//
//    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
//        let post = postArray[indexPath.row - 1]
//        let titleProvider = NSItemProvider(object: post.authorLabel as NSString)
//        let imageProvider = NSItemProvider(object: post.image!)
//        return [UIDragItem(itemProvider: titleProvider), UIDragItem(itemProvider: imageProvider)]
//    }
//
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        originIndex = indexPath.row
//        return dragItems(for: indexPath)
//    }
//
//    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
//
//        let destinationIndexPath: IndexPath
//
//               if let indexPath = coordinator.destinationIndexPath {
//                   destinationIndexPath = indexPath
//               } else {
//                   // get from last row
//                   let section = tableView.numberOfSections - 1
//                   let row = tableView.numberOfRows(inSection: section)
//                   destinationIndexPath = IndexPath(row: row, section: section)
//               }
//
//               let rowInd = destinationIndexPath.row
//
//               let group = DispatchGroup()
//
//               var postDescription = String()
//               group.enter()
//               coordinator.session.loadObjects(ofClass: NSString.self) { objects in
//                   let uStrings = objects as! [String]
//                   for uString in uStrings {
//                       postDescription = uString
//                       break
//                   }
//                   group.leave()
//               }
//
//               var postImage = UIImage()
//               group.enter()
//               coordinator.session.loadObjects(ofClass: UIImage.self) { objects in
//                   let uImages = objects as! [UIImage]
//                   for uImage in uImages {
//                       postImage = uImage
//                       break
//                   }
//                   group.leave()
//               }
//
//               group.notify(queue: .main) {
//                   // delete moved post if moved
//                   if coordinator.proposal.operation == .move {
//                       postArray.remove(at: self.originIndex)
//                   }
//                   // insert new post
//                   let newPost = Post(authorLabel: "new", descriptionLabel: postDescription,image: postImage, likes: 0, views: 0, date: Date() )
//                   postArray.insert(newPost, at: rowInd - 1)
//
//                   tableView.reloadData()
//               }
//
//    }
//}
//
