//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Krime Loma    on 8/14/22.
//

import UIKit
import SnapKit

class PostTableViewCell: UITableViewCell {
    
    var isLiked: Bool = false
    var index : Int?
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    var posts = [PostData]()
    var originaIndex = Int()
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
        views.numberOfLines = 0
        views.text = "Views : "
        views.textAlignment = .right
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    private lazy var stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var imageStackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = UIColor.createColor(lightMode: .black, darkMode: .darkGray)
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        setViews()
        setConstraints()
    }
    
    private func setViews () {
        self.addSubview(self.stackView)
        self.posts = coreDataManager.posts
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
            self.viewsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.39),
            self.viewsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setup(with viewModel: [Post], index: Int) {
        self.authorLabel.text = viewModel[index].authorLabel
        self.postImage.image =  viewModel[index].image
        self.descriptionTextView.text = viewModel[index].descriptionLabel
        let likePluralLocalization = NSLocalizedString("likes-plural", comment: "")
        let formattedLike = String(format: likePluralLocalization, viewModel[index].likes)
        self.likesLabel.text = "\(formattedLike) : \(viewModel[index].likes)"
        let viewPluralLocalization = NSLocalizedString("views-plural", comment: "")
        let formattedViews = String(format: viewPluralLocalization, viewModel[index].views)
        self.viewsLabel.text = "\(formattedViews) : \(viewModel[index].views)"
        self.posts = coreDataManager.posts
        let indexPost = posts.firstIndex { post in
            post.descriptionLabel == self.descriptionTextView.text
        }
        if let index = indexPost {
            self.isLiked = posts[index].isLiked
        } else {
            self.isLiked = false
        }
        
        if isLiked {
            likeImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeImage.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        originaIndex = index
    }
    
    @objc func likeActionTap () {
        let likeHelper = LikeHelper()
        likeHelper.delegate = self
        likeHelper.likePost(isLiked: &isLiked)
    }
}

extension PostTableViewCell: LikeDelegate {
    
    func likePost(_ isLike: inout Bool)   {
        self.posts = coreDataManager.posts
        let index = self.index  ?? 0
        if isLike {
            //adding post in core data
            self.coreDataManager.likePost(originalPost: postArray[index])
            self.likeImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            //deleting post in core data
            let indexForDeletePost = self.posts.firstIndex { corePost in
                corePost.authorLabel == postArray[index].authorLabel &&
                corePost.descriptionLabel == postArray[index].descriptionLabel
            }
            if let index = indexForDeletePost {
                self.coreDataManager.unlike(post: self.posts[index])
            }
            self.likeImage.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
