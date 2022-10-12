//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Krime Loma    on 8/17/22.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    
    private lazy var photoLabel : UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var iconImage : UIImageView = {
        let icon = UIImageView ()
        icon.image = UIImage(systemName: "arrow.right")
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false

        return icon
    }()
    
    private lazy var firstImage : UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        setProperties(with: image)

        return image
    }()
    
    private lazy var secondImage : UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        setProperties(with: image)

        return image
    }()
    
    private lazy var thirdImage : UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        setProperties(with: image)

        return image
    }()
    
    private lazy var fourthImage : UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        setProperties(with: image)
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light}
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews () {
        self.addSubview(self.photoLabel)
        self.addSubview(self.iconImage)
        self.addSubview(self.firstImage)
        self.addSubview(self.secondImage)
        self.addSubview(self.thirdImage)
        self.addSubview(self.fourthImage)
    }
    
    
    private func setConstraints () {
        
        NSLayoutConstraint.activate([
        
            self.photoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.photoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 12),
            
            self.iconImage.centerYAnchor.constraint(equalTo: self.photoLabel.centerYAnchor),
            self.iconImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            self.iconImage.heightAnchor.constraint(equalTo: photoLabel.heightAnchor, multiplier: 1),
            self.iconImage.widthAnchor.constraint(equalTo: self.iconImage.heightAnchor, multiplier: 1.2),
            
            self.firstImage.topAnchor.constraint(equalTo: self.photoLabel.bottomAnchor, constant: 12),
            self.firstImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),

            self.firstImage.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4),
            self.firstImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            self.firstImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            

            self.secondImage.topAnchor.constraint(equalTo: self.firstImage.topAnchor),
            self.secondImage.leadingAnchor.constraint(equalTo: self.firstImage.trailingAnchor, constant: 8),
            self.secondImage.widthAnchor.constraint(equalTo: self.firstImage.widthAnchor),
            self.secondImage.heightAnchor.constraint(equalTo: firstImage.heightAnchor, multiplier: 1),

            self.thirdImage.topAnchor.constraint(equalTo: self.secondImage.topAnchor),
            self.thirdImage.leadingAnchor.constraint(equalTo: self.secondImage.trailingAnchor, constant: 8),
            self.thirdImage.widthAnchor.constraint(equalTo: self.secondImage.widthAnchor),
            self.thirdImage.heightAnchor.constraint(equalTo: firstImage.heightAnchor, multiplier: 1),

            self.fourthImage.topAnchor.constraint(equalTo: self.firstImage.topAnchor),
            self.fourthImage.leadingAnchor.constraint(equalTo: self.thirdImage.trailingAnchor, constant: 8),
            self.fourthImage.widthAnchor.constraint(equalTo: self.firstImage.widthAnchor),
            self.fourthImage.heightAnchor.constraint(equalTo: firstImage.heightAnchor, multiplier: 1),
            self.fourthImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }
    
    
    private func setProperties (with image: UIImageView) {
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
    }
    
    
    func setup(with viewModel: [UIImage]) {
        self.firstImage.image = viewModel[0]
        self.secondImage.image = viewModel[1]
        self.thirdImage.image = viewModel[2]
        self.fourthImage.image = viewModel[3]
    }
}
