//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//
import StorageService
import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private var initialAvatarFrame = CGRect(x: 16, y: 16, width: 120, height: 120)
    
    private lazy var tableView: UITableView = {
        let table = UITableView (frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 140
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
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        image.layer.cornerRadius = self.initialAvatarFrame.height/2
        image.image = UIImage(named: "cat")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
#if DEBUG
        tableView.backgroundColor = .systemRed
#else
        tableView.backgroundColor = .systemMint
#endif
        
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light }
        self.view.backgroundColor = .secondarySystemBackground
        self.tabBarController?.tabBar.backgroundColor = .secondarySystemBackground
        setViews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
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
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        avaImage.snp.makeConstraints { make in
            make.width.equalTo(initialAvatarFrame.width)
            make.height.equalTo(initialAvatarFrame.height)
            make.leading.equalToSuperview().offset(initialAvatarFrame.minX)
            make.top.equalToSuperview().offset(initialAvatarFrame.minY)
        }
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalTo(backButton.snp.width)
        }
    }
    
    func animateAvatar (ava: UIImageView) {
        
        
        //  MARK: Keyframe Animation
        
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.initialAvatarFrame = ava.frame
                
                self.avaImage.snp.remakeConstraints { make in
                    make.width.equalToSuperview()
                    make.height.equalTo(self.view.snp.width)
                    make.leading.equalToSuperview().offset(0)
                    make.top.equalTo(self.view.frame.width/3)
                }
                
                self.avaImage.layoutIfNeeded()
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
        
        self.avaImage.snp.remakeConstraints { make in
            make.width.equalTo(self.initialAvatarFrame.width)
            make.height.equalTo(self.initialAvatarFrame.height)
            make.leading.equalToSuperview().offset(self.initialAvatarFrame.minX)
            make.top.equalToSuperview().offset(initialAvatarFrame.minY)
        }
        
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
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileTableHeaderView
        headerView?.profileVC = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "Вы несете ответсвенность за каждое слово в публичном пространстве."
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == .zero {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
            cell.setup(with: photosArray)
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PostTableViewCell
            cell.setup(with: postArray, index: indexPath.row)
            return cell
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = PhotosViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
