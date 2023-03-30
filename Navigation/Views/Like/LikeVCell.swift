//
//  LikeVCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 26/3/23.
//

import UIKit
import CoreData

class LikeVCell: UICollectionViewCell {
    
    var isLiked: Bool = false
    var index : Int! {
        didSet {
        }
    }
    var indexPath : IndexPath?
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    var fetchResultController: NSFetchedResultsController<PostData>?
    weak var delegate : MyCellDelegate?
    var postArray: [AccountPosts]! {
        didSet {
            
        }
    }
    
    var posts = [PostData]()
    var originaIndex = Int()
    weak var profileVC : ProfileViewController?
    private var initialAvatarFrame = CGRect(x: 26, y: 16, width: 60, height: 60)
    
    private lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var avatarImage : UIImageView = {
        let avatar = UIImageView()
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = self.initialAvatarFrame.height/2
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
        button.tintColor = UIColor.createColor(lightMode: .black, darkMode: .white)
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
        button.addTarget(self, action: #selector(tapedMoreActionButton), for: .touchUpInside)
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
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 12)
        //        button.addTarget(self, action: #selector(likeActionTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView ()
        image.contentMode = .scaleAspectFill
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
        likes.backgroundColor = .red
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()
    
    private lazy var commentsLabel: UILabel = {
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
        self.addSubview(stackView)
        stackView.addArrangedSubview(avatarImage)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(authorProfLabel)
        stackView.addArrangedSubview(backgroundColorView)
        stackView.addArrangedSubview(separatorVertical)
        stackView.addArrangedSubview(descriptionTextView)
        stackView.addArrangedSubview(showMoreButton)
        stackView.addArrangedSubview(postImage)
        stackView.addArrangedSubview(separatorHorizontal)
        stackView.addArrangedSubview(likesButton)
        stackView.addArrangedSubview(commentsButton)
        stackView.addArrangedSubview(favouriteButton)
        
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
    
    @objc func tapedMoreActionButton () {
        // show menu
        //show black background
        profileVC?.setMenu()
        print("-------\(frame.height)")
    }
    
    
    private func setConstraints () {
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.top).offset(25)
            make.leading.equalTo(stackView.snp.leading).offset(16)
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
        
        separatorVertical.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(20)
            make.width.equalTo(0.5)
            make.leading.equalTo(stackView.snp.leading).offset(28)
            make.bottom.equalTo(stackView.snp.bottom).offset(-69)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(separatorVertical.snp.top)
            make.leading.equalTo(separatorVertical.snp.trailing).offset(24)
            make.trailing.equalTo(stackView.snp.trailing).offset(-18)
        }
        showMoreButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(4)
            make.leading.equalTo(separatorVertical.snp.trailing).offset(24)
            make.trailing.equalTo(stackView.snp.trailing).offset(-18)
        }
        
        postImage.snp.makeConstraints { make in
            make.top.equalTo(showMoreButton.snp.bottom).offset(10)
            make.leading.equalTo(separatorVertical.snp.trailing).offset(24)
            make.trailing.equalTo(stackView.snp.trailing).offset(-18)
            make.bottom.equalTo(separatorHorizontal.snp.top).offset(-16)
        }
        
        separatorHorizontal.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.bottom).offset(-48)
            make.centerX.equalTo(stackView.snp.centerX)
            make.height.equalTo(0.5)
            make.width.equalTo(stackView.snp.width)
        }
        
        likesButton.snp.makeConstraints { make in
            make.top.equalTo(separatorHorizontal.snp.bottom).offset(10)
            make.leading.equalTo(stackView.snp.leading).offset(52)
            make.bottom.equalTo(stackView.snp.bottom).offset(-18)
        }
        
        commentsButton.snp.makeConstraints { make in
            make.leading.equalTo(likesButton.snp.trailing).offset(16)
            make.centerY.equalTo(likesButton.snp.centerY)
        }
        
        favouriteButton.snp.makeConstraints { make in
            make.trailing.equalTo(stackView.snp.trailing).offset(-18)
            make.centerY.equalTo(likesButton.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setup(with posts: [PostData], index: Int, account: Account?) {
        
        self.avatarImage.image = UIImage(data: posts[index].profileImage ?? Data())
        self.authorLabel.text = posts[index].authorLabel
        self.postImage.image =  UIImage(data: posts[index].postImage ?? Data())
        self.authorProfLabel.text = posts[index].statusLabel
        
        commentsButton.setTitle(" \(posts[index].comments)", for: .normal)
        likesButton.setTitle(" \(posts[index].likes)", for: .normal)
        self.descriptionTextView.text = posts[index].descriptionPost
        let likePluralLocalization = NSLocalizedString("likes-plural", comment: "")
        let formattedLike = String(format: likePluralLocalization, "\(posts[index].likes)")
        self.likesLabel.text = "\(formattedLike) : \(posts[index].likes)"
        let viewPluralLocalization = NSLocalizedString("views-plural", comment: "")
        let formattedViews = String(format: viewPluralLocalization, "\(posts[index].comments)")
        self.commentsLabel.text = "\(formattedViews) : \(posts[index].comments)"
        self.posts = coreDataManager.posts
        self.isLiked = posts[index].isLiked
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

extension LikeVCell: LikeDelegate {
    
    func likePost(_ isLike: inout Bool)   {
        print("unlike ")
        self.posts = coreDataManager.posts
        let indexForDeletePost = self.posts.firstIndex { corePost in
            corePost.descriptionPost == descriptionTextView.text
        }
        self.coreDataManager.unlike(post: self.posts[indexForDeletePost!])
        self.favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

    }
}


