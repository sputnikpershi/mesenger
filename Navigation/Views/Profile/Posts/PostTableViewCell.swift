//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Krime Loma    on 8/14/22.
//

import UIKit
import StorageService
import SnapKit

class PostTableViewCell: UITableViewCell {
    
    var isLiked: Bool = false
    var index : Int?
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    
    private lazy var authorLabel: UILabel = {
        let author = UILabel()
        author.font = UIFont.boldSystemFont(ofSize: 20)
        author.numberOfLines = 2
        author.translatesAutoresizingMaskIntoConstraints  = false
        return author
    }()
    
    private lazy var likeImage : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.isUserInteractionEnabled = true
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(likeActionTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var descriptionTextView: UILabel = {
        let description = UILabel()
        description.numberOfLines = 0
        description.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        description.textColor = .systemGray
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView ()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var likesLabel: UILabel = {
        let likes = UILabel()
        likes.text = "Likes : "
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()
    
    private lazy var viewsLabel: UILabel = {
        let views = UILabel()
        views.text = "Views : "
        views.textAlignment = .right
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    private lazy var stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .systemOrange
        return stack
    }()
    
    private lazy var imageStackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .black
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light}
        setViews()
        setConstraints()
    }
    
    private func setViews () {
        self.addSubview(self.stackView)
        stackView.addArrangedSubview(self.authorLabel)
        stackView.addArrangedSubview(self.imageStackView)
        stackView.addArrangedSubview(self.descriptionTextView)
        stackView.addArrangedSubview(self.likesLabel)
        stackView.addArrangedSubview(self.viewsLabel)
        self.addSubview(self.authorLabel)
        self.addSubview(self.imageStackView)
        imageStackView.addArrangedSubview(self.postImage)
        self.addSubview(self.descriptionTextView)
        self.addSubview(self.likesLabel)
        self.addSubview(self.viewsLabel)
        self.addSubview(self.likeImage)
        likeImage.snp.makeConstraints { make in
            make.trailing.equalTo(self.postImage.snp.trailing).offset(-8)
            make.bottom.equalTo(self.postImage.snp.bottom).offset(-8)
            make.height.width.equalTo(35)
        }
    }
    
    private func setConstraints () {
        NSLayoutConstraint.activate([
            
            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.authorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.authorLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            self.imageStackView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 12),
            self.imageStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier:  1),
            self.imageStackView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            
            self.descriptionTextView.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 16),
            self.descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.likesLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            self.likesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.likesLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            //            self.likesLabel.heightAnchor.constraint(equalToConstant: 40),
            self.likesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            
            self.viewsLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            self.viewsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.viewsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            self.viewsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setup(with viewModel: [Post], index: Int) {
        self.authorLabel.text = viewModel[index].authorLabel
        self.postImage.image = UIImage(named: viewModel[index].image)
        self.descriptionTextView.text = viewModel[index].descriptionLabel
        self.likesLabel.text = "Likes : \(viewModel[index].likes)"
        self.viewsLabel.text = "Views : \(viewModel[index].views)"
        
        let posts = coreDataManager.posts
        let indexPost = posts.firstIndex { post in
            post.descriptionLabel == self.descriptionTextView.text
        }
        if let index = indexPost {
            self.isLiked = posts[index].isLiked
        }
        
        if isLiked {
            likeImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        print(index)
    }
    
    @objc func likeActionTap () {
       
        guard let index = self.index else { return }
        
        self.isLiked.toggle()
        
        if isLiked {
            coreDataManager.likePost(originalPost: postArray[index])
            likeImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            
            //getting array from core data
            let corePosts = coreDataManager.posts
            //getting index in core data array
            let indexForDeletePost = corePosts.firstIndex { corePost in
                corePost.authorLabel == postArray[index].authorLabel &&
                corePost.descriptionLabel == postArray[index].descriptionLabel
           }
            //deleting post in core data
            if let index = indexForDeletePost {
                coreDataManager.unlike(post: corePosts[index])
            }
            likeImage.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
}
