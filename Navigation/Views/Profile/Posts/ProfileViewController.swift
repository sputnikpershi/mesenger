//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//
import UIKit
import CoreData
import UniformTypeIdentifiers

class ProfileViewController: UIViewController {
    
    var coordinator : ProfileTabCoordinator?
    private var initialAvatarFrame = CGRect(x: 26, y: 16, width: 60, height: 60)
    private var viewModel : ProfileViewModel?
    var postData = [PostData]()
    var originIndex = Int()
    
    // MARK: INIT
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var tableView: UITableView = {
        let table = UITableView (frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.dragInteractionEnabled = true
        table.dragDelegate = self
        table.dropDelegate = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 140
        table.backgroundColor = .white
        table.separatorStyle = .none

        table.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
        table.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    } ()
    
    
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("reload ProfileVC")
        }
    }
    
    private func setViews() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.avaImage)
        self.view.addSubview(self.backButton)
        
        self.avatarWidthConstant = self.avaImage.widthAnchor.constraint(equalToConstant: initialAvatarFrame.width)
        self.avatarHeightConstant = self.avaImage.heightAnchor.constraint(equalToConstant: initialAvatarFrame.height)
        self.avatarLeadingConstant = self.avaImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: initialAvatarFrame.minX)
        self.avatarTopConstant = self.avaImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: initialAvatarFrame.minY)
    }
    
    private func setConstraints () {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            avatarTopConstant, avatarLeadingConstant, avatarWidthConstant, avatarHeightConstant,
            
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.backButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.backButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1),
            self.backButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1),
            
        ].compactMap({ $0 }))
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
}

// MARK: EXTENSION

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileTableHeaderView
        headerView?.profileVC = self
        headerView?.setup(user: viewModel!.user)// Передача данных user в элементы ProfileTableHeaderView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postArray.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == .zero {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
            cell.setup(with: photosArray)
            cell.buttonTapCallback = {
                print("COmething")
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PostTableViewCell
            cell.index = indexPath.row - 1
            cell.setup(with: postArray, index: indexPath.row - 1 )
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = AlbomsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else
        { return lightMode }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}


extension ProfileViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if tableView.hasActiveDrag {
                    return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
                } else {
                    return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
                }
    }
   
    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        let post = postArray[indexPath.row - 1]
        let titleProvider = NSItemProvider(object: post.authorLabel as NSString)
        let imageProvider = NSItemProvider(object: post.image!)
        return [UIDragItem(itemProvider: titleProvider), UIDragItem(itemProvider: imageProvider)]
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        originIndex = indexPath.row
        return dragItems(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
       
        let destinationIndexPath: IndexPath

               if let indexPath = coordinator.destinationIndexPath {
                   destinationIndexPath = indexPath
               } else {
                   // get from last row
                   let section = tableView.numberOfSections - 1
                   let row = tableView.numberOfRows(inSection: section)
                   destinationIndexPath = IndexPath(row: row, section: section)
               }
                       
               let rowInd = destinationIndexPath.row
               
               let group = DispatchGroup()
               
               var postDescription = String()
               group.enter()
               coordinator.session.loadObjects(ofClass: NSString.self) { objects in
                   let uStrings = objects as! [String]
                   for uString in uStrings {
                       postDescription = uString
                       break
                   }
                   group.leave()
               }
               
               var postImage = UIImage()
               group.enter()
               coordinator.session.loadObjects(ofClass: UIImage.self) { objects in
                   let uImages = objects as! [UIImage]
                   for uImage in uImages {
                       postImage = uImage
                       break
                   }
                   group.leave()
               }
               
               group.notify(queue: .main) {
                   // delete moved post if moved
                   if coordinator.proposal.operation == .move {
                       postArray.remove(at: self.originIndex)
                   }
                   // insert new post
                   let newPost = Post(authorLabel: "new", descriptionLabel: postDescription,image: postImage , likes: 0, views: 0)
                   postArray.insert(newPost, at: rowInd - 1)
                   
                   tableView.reloadData()
               }
        
    }
}

