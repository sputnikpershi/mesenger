//
//  PostHeader.swift
//  Navigation
//
//  Created by Kiryl Rakk on 14/3/23.
//

import UIKit
import SnapKit

class PostHeader: UICollectionReusableView {
    
    static let identifier = "PostHeader"
    private lazy var avatarImage : UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "avatar")
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = 15
        avatar.isUserInteractionEnabled = true
        return avatar
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let author = UILabel()
        author.font = UIFont(name: "Inter-Medium", size: 12)
        author.text = "mary-super"
        author.textColor = .orange
        author.numberOfLines = 2
        author.translatesAutoresizingMaskIntoConstraints  = false
        return author
    }()
    private lazy var authorProfLabel: UILabel = {
        let author = UILabel()
        author.textColor = .lightGray
        author.font = UIFont(name: "Inter-Medium", size: 12)
        author.text = "учитель"
        author.numberOfLines = 2
        author.translatesAutoresizingMaskIntoConstraints  = false
        return author
    }()
    
    private lazy var postImage : UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "1")
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        
        avatar.layer.cornerRadius = 10
        return avatar
    }()
    
    private lazy var postText : UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "Inter-Regular", size: 14)
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.18
        text.attributedText = NSMutableAttributedString(string: "With prototyping in Figma, you can create multiple flows for your prototype in one page to preview a user's full journey and experience through your designs. A flow is a path users take through the network of connected frames that make up your prototype. For example, you can create a prototype for a shopping app that includes a flow for account creation, another for browsing items, and another for the checkout process–all in one page.", attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return text
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
//        button.addTarget(self, action: #selector(likeActionTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var separator : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        return line
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayers() {
        
        self.addSubview(avatarImage)
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.height.width.equalTo(30)
            make.leading.equalToSuperview().offset(29)
        }
        self.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.top)
            make.leading.equalTo(avatarImage.snp.trailing).offset(16)
        }
        self.addSubview(authorProfLabel)
        authorProfLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom)
            make.leading.equalTo(avatarImage.snp.trailing).offset(16)
        }
        self.addSubview(postImage)
        postImage.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(240)
        }
        self.addSubview(postText)
        postText.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-26)
        }
        self.addSubview(likesButton)
        likesButton.snp.makeConstraints { make in
            make.top.equalTo(postText.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(52)
        }
        self.addSubview(commentsButton)
        commentsButton.snp.makeConstraints { make in
            make.leading.equalTo(likesButton.snp.trailing).offset(16)
            make.centerY.equalTo(likesButton.snp.centerY)
        }
        self.addSubview(favouriteButton)
        favouriteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-26)
            make.centerY.equalTo(likesButton.snp.centerY)
        }
        self.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(likesButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview().offset(-18)
        }
    }
    
    
    func setPost(post: AccountPosts, account: Account) {
        avatarImage.image = account.avatar
        nickNameLabel.text = account.nickname
        authorProfLabel.text = account.status
        postImage.image = post.image
        postText.text = post.descriptionLabel
        likesButton.setTitle(" \(post.likes)", for: .normal)
        commentsButton.setTitle(" \(post.comments.count)", for: .normal)
    }
}
