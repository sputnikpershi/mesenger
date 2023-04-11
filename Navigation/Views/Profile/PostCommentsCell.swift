//
//  PostCommentsCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 14/3/23.
//

import UIKit

class PostCommentsCell: UICollectionViewCell {
    
    private lazy var avatarImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar")
        return image
    }()
    private lazy var nickNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 12)
        label.text = "mary-super"
        label.textColor = .orange
        return label
    }()
    
    private lazy var comentsLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.495, green: 0.507, blue: 0.512, alpha: 1)
        label.font = UIFont(name: "Inter-Regular", size: 12)
        label.text = "Все отлично, прикольная статься."
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.767, green: 0.792, blue: 0.804, alpha: 1)
        label.font = UIFont(name: "Inter-Regular", size: 12)
        label.text = "19 октября"
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var likesButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        button.setTitle(" 3", for: .normal)
        return button
    }()
    
    private lazy var answerButton : UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 12)
        button.setTitle("Ответить", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setCell(comment: Comments, postIndex: Int, post: AccountPosts) {
        comentsLabel.text = comment.commentText
        avatarImage.image = post.authorImage
        nickNameLabel.text = post.authorLabel
        likesButton.setTitle(" \(comment.likes)", for: .normal)
        dateLabel.text =  "\(comment.date.formatted(date: .abbreviated, time: .omitted))"
        
    }
    
    private func setLayers() {
        self.addSubview(avatarImage)
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.height.width.equalTo(15)
        }
        
        self.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImage)
            make.leading.equalTo(avatarImage.snp.trailing).offset(7)
        }
        
        self.addSubview(comentsLabel)
        comentsLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(nickNameLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(comentsLabel.snp.bottom).offset(3)
            make.leading.equalTo(nickNameLabel.snp.leading)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        self.addSubview(likesButton)
        likesButton.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImage.snp.centerY)
            make.trailing.equalToSuperview().offset(-22)
        }
        self.addSubview(answerButton)
        answerButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-22)
            make.centerY.equalTo(dateLabel.snp.centerY)
        }
    }
}
