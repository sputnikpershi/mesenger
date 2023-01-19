//
//  LIkeTableViewCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 2/12/22.
//

import UIKit
import CoreData

class LIkeTableViewCell: UITableViewCell {
    
    weak var delegate : MyCellDelegate?
    var index : Int?
    var indexPath : IndexPath?
    var isLiked: Bool = false
    var post: PostData?
    var fetchResultController: NSFetchedResultsController<PostData>?
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    var postData: [PostData]?
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    lazy var likeImage : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(likeActionTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var authorLabel: UILabel = {
        let author = UILabel()
        author.font = UIFont.boldSystemFont(ofSize: 20)
        author.numberOfLines = 2
        author.translatesAutoresizingMaskIntoConstraints  = false
        return author
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
        
        self.addSubview(self.authorLabel)
        self.addSubview(self.imageStackView)
        imageStackView.addArrangedSubview(self.postImage)
        self.addSubview(self.descriptionTextView)
        self.addSubview(self.likesLabel)
        self.addSubview(self.viewsLabel)
        self.addSubview(self.likeImage)
        
        
    }
    
    private func setConstraints () {
        NSLayoutConstraint.activate([
            
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
        likeImage.snp.makeConstraints { make in
            make.trailing.equalTo(self.postImage.snp.trailing).offset(-8)
            make.bottom.equalTo(self.postImage.snp.bottom).offset(-8)
            make.height.width.equalTo(35)
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(with viewModel: [PostData], index: Int) {
        self.authorLabel.text = viewModel[index].authorLabel
        self.postImage.image = UIImage(named: viewModel[index].image ?? "")
        self.descriptionTextView.text = viewModel[index].descriptionLabel
        self.likesLabel.text = "Likes : \(viewModel[index].likes)"
        self.viewsLabel.text = "Views : \(viewModel[index].views)"
        self.isLiked = viewModel[index].isLiked
        if viewModel[index].isLiked {
            self.likeImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            self.likeImage.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    func setup(with post: PostData) {
        self.authorLabel.text = post.authorLabel
        self.postImage.image = UIImage(named: post.image ?? "")
        self.descriptionTextView.text = post.descriptionLabel
        self.likesLabel.text = "Likes : \(post.likes)"
        self.viewsLabel.text = "Views : \(post.views)"
        self.isLiked = post.isLiked
        if post.isLiked {
            self.likeImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            self.likeImage.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    @objc func likeActionTap () {
        
        if let post {
            coreDataManager.persistentContainer.viewContext.delete(post)
            coreDataManager.saveContext()
            delegate?.reloadData()
        }
    }
    
}

