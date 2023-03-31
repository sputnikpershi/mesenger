//
//  FeedViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//
import SnapKit
import UIKit

protocol SearchPostDelegate: AnyObject {
    func searchPost(text: String?)
}

class HomeViewController: UICollectionViewController {
    
     var viewModel : ProfileViewModel?
    private lazy var localNotificationsService = LocalNotificationsService()
    var searchText  = ""
    var popupMenu = PopupMenu()
    var navBarHeight : CGFloat?
    
    lazy var menuBar : MenuBar = {
        let menu = MenuBar()
        menu.homeVC = self
        return menu
    }()
    
    
    lazy var friendsBar : FriendsBar = {
        let menu = FriendsBar(frame: .zero)
        menu.homeVC = self
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navBarHeight = navigationController?.navigationBar.frame.height
        friendsBar.viewModel = viewModel
        collectionView.delegate = self
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.dataSource = self
        collectionView.register(HomeCollectionCell.self, forCellWithReuseIdentifier: "cID")
        collectionView.contentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
        collectionView.isPagingEnabled = true
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        collectionView.collectionViewLayout = flowLayout
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        setupMenuBar()
        setNavigation()
    }
    
    private func setNavigation() {
        let navTitleLabel = UILabel()
        navTitleLabel.text  = "Главная"
        navTitleLabel.font = UIFont(name: "Inter-SemiBold", size: 18)
        navTitleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 50, height: view.frame.height)
        navigationItem.titleView = navTitleLabel
        let pushBarButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(tapAlertAction))
        let searchBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchAction))
        navigationItem.rightBarButtonItems = [pushBarButton, searchBarButton]
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
//       print( viewModel?.searchAccountPosts().count)
//       print( viewModel?.searchAccountPosts(searchText: "видео" ).count)
    }
   
    func setMenu () {
        popupMenu.view = self
        popupMenu.showSettings()
    }
    
    @objc func searchAction () {
        let alertController = UIAlertController(title: "Найти пост", message: "Введите слово по которому хотите найти пост", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter name"
            }
            let saveAction = UIAlertAction(title: "save", style: .default, handler: { [weak self] alert -> Void in
                if let textField = alertController.textFields?[0] {
                    if let searchText = textField.text, searchText.count > 0 {
                        
                    }
                }
            })
            
            let cancelAction = UIAlertAction(title: "cancel", style: .destructive, handler: {
                (action : UIAlertAction!) -> Void in })
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            alertController.preferredAction = saveAction
            self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tapAlertAction () {
            localNotificationsService.registeForLatestUpdatesIfPossible()
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cID", for: indexPath) as! HomeCollectionCell
            cell.homeVC = self
            cell.menuIndex = indexPath.row
            cell.setViewModel(viewModel: viewModel)
            return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let device = UIDevice.current
        let deviceHeight = device.model == "iPhone" ? 120 : 79
        let height = view.frame.height - menuBar.frame.height - friendsBar.frame.height - navBarHeight! - CGFloat(deviceHeight)
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = Int(Float(targetContentOffset.pointee.x)/Float(scrollView.frame.size.width))
        menuBar.collectionView.selectItem(at: IndexPath(row: x, section: 0), animated: true, scrollPosition: [])
    }
    func scrollToMenuIndex (menuIndex: Int) {
        collectionView.scrollToItem(at: IndexPath(row: menuIndex, section: 0), at: [] , animated: true)
    }
}
