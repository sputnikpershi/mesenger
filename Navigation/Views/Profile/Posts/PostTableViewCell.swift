//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Krime Loma    on 8/14/22.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
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
    }
}
