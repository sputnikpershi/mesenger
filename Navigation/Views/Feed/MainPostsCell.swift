//
//  PostsCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 6/3/23.
//

import UIKit

class MainPostsCell: UICollectionViewCell {
    
    var isLiked: Bool = false
    var index : Int?
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    var posts = [PostData]()
    var originaIndex = Int()
    private var initialAvatarFrame = CGRect(x: 26, y: 16, width: 60, height: 60)
    
    private lazy var avatarImage : UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "avatar")
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = self.initialAvatarFrame.height/2
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.isUserInteractionEnabled = true
        return avatar
    }()
    
    private lazy var authorLabel: UILabel = {
        let author = UILabel()
        author.font = UIFont.boldSystemFont(ofSize: 20)
        author.text = "Mary Golusheva"
        author.numberOfLines = 2
        author.translatesAutoresizingMaskIntoConstraints  = false
        return author
    }()
    private lazy var authorProfLabel: UILabel = {
        let author = UILabel()
      
        author.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        author.font = UIFont(name: "Inter-Regular", size: 14)
        author.numberOfLines = 2
        author.translatesAutoresizingMaskIntoConstraints  = false
        return author
    }()
    
    private lazy var likesButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        return button
    }()
    
    private lazy var commentsButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        button.isUserInteractionEnabled = true
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()
    
    private lazy var favouriteButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .black
        button.isUserInteractionEnabled = true
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(likeActionTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var moreImageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menu1"), for: .normal)
        button.isUserInteractionEnabled = true
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()
    
    private lazy var descriptionTextView: UILabel = {
        let description = UILabel()
        description.numberOfLines = 4
        description.font = UIFont(name: "Inter-Regular", size: 14)
        description.textColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1)
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private lazy var showMoreButton : UIButton = {
        let button = UIButton()
        button.setTitle("Показать полностью...", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 12)
        //        button.addTarget(self, action: #selector(likeActionTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView ()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var separatorVertical : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        return line
    } ()
    
    private lazy var separatorHorizontal : UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        return line
    } ()
    
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
    
    private lazy var backgroundColorView : UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    private func setViews () {
        self.posts = coreDataManager.posts
        self.addSubview(self.avatarImage)
        self.addSubview(self.authorLabel)
        self.addSubview(moreImageButton)
        self.addSubview(authorProfLabel)
        self.addSubview(self.backgroundColorView)
        self.addSubview(separatorVertical)
        self.addSubview(self.descriptionTextView)
        self.addSubview(showMoreButton)
        self.addSubview(postImage)
        self.addSubview(separatorHorizontal)
        self.addSubview(self.likesButton)
        self.addSubview(commentsButton)
        self.addSubview(favouriteButton)
    }
    
    private func setConstraints () {
        
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(60)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.top)
            make.leading.equalTo(avatarImage.snp.trailing).offset(16)
        }
        
        authorProfLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(8)
            make.leading.equalTo(avatarImage.snp.trailing).offset(16)
        }
        
        moreImageButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.trailing.equalToSuperview().offset(-26)
            make.height.equalTo(21)
            make.width.equalTo(5)
        }

        backgroundColorView.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
//
        separatorVertical.snp.makeConstraints { make in
            make.top.equalTo(backgroundColorView.snp.top).offset(20)
            make.width.equalTo(0.5)
            make.leading.equalTo(backgroundColorView.snp.leading).offset(28)
            make.bottom.equalTo(backgroundColorView.snp.bottom).offset(-69)

        }

        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(backgroundColorView.snp.top).offset(10)
            make.leading.equalTo(backgroundColorView.snp.leading).offset(52)
            make.trailing.equalTo(backgroundColorView.snp.trailing).offset(-15)
        }
//
        showMoreButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom)
            make.leading.equalTo(separatorVertical.snp.trailing).offset(24)
        }

        postImage.snp.makeConstraints { make in
            make.top.equalTo(showMoreButton.snp.bottom).offset(10)
            make.leading.equalTo(separatorVertical.snp.trailing).offset(24)
            make.trailing.equalTo(backgroundColorView.snp.trailing).offset(-24)
            make.height.equalTo(postImage.snp.width).multipliedBy(0.416)
        }

        separatorHorizontal.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(0.5)
            make.width.equalToSuperview()
        }

        likesButton.snp.makeConstraints { make in
            make.top.equalTo(separatorHorizontal.snp.bottom).offset(10)
            make.leading.equalTo(backgroundColorView.snp.leading).offset(52)
            make.bottom.equalTo(backgroundColorView.snp.bottom).offset(-18)
        }
        
        commentsButton.snp.makeConstraints { make in
            make.leading.equalTo(likesButton.snp.trailing).offset(16)
            make.centerY.equalTo(likesButton.snp.centerY)
        }

        favouriteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-18)
            make.centerY.equalTo(likesButton.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setup(with viewModel: [AccountPosts], index: Int) {
        self.authorLabel.text = "\(maryAccount.name) \(maryAccount.surname)"
        self.postImage.image =  viewModel[index].image
        self.authorProfLabel.text = maryAccount.status
        commentsButton.setTitle(" \(viewModel[index].comments.count)", for: .normal)
        likesButton.setTitle(" \(viewModel[index].likes)", for: .normal)
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
            favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        originaIndex = index
    }
    
    @objc func likeActionTap () {
        let likeHelper = LikeHelper()
        likeHelper.delegate = self
        likeHelper.likePost(isLiked: &isLiked)
    }
}

extension MainPostsCell: LikeDelegate {
    
    func likePost(_ isLike: inout Bool)   {
        self.posts = coreDataManager.posts
        let index = self.index  ?? 0
        if isLike {
            //adding post in core data
            self.coreDataManager.likePost(originalPost: postArray[index])
            self.favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            //deleting post in core data
            let indexForDeletePost = self.posts.firstIndex { corePost in
                corePost.authorLabel == postArray[index].authorLabel &&
                corePost.descriptionLabel == postArray[index].descriptionLabel
            }
            if let index = indexForDeletePost {
                self.coreDataManager.unlike(post: self.posts[index])
            }
            self.favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        
           
    }
}
