//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Krime Loma    on 8/17/22.
//

import UIKit

class PhotosTableViewCell: UICollectionViewCell {

    var buttonTapCallback: () -> ()  = { }

    private lazy var photoLabel : UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        let localizationText = NSLocalizedString("profile-photo-title", comment: "")
        label.text = localizationText
        label.font = UIFont(name: "Inter-Medium", size: 16)
        return label
    }()
    
    private lazy var iconImage : UIImageView = {
        let icon = UIImageView ()
        icon.image = UIImage(named: "next1")
        icon.tintColor = UIColor.createColor(lightMode: .black, darkMode: .white)
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
    private lazy var fifthImage : UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        setProperties(with: image)
        return image
    }()
    
    private lazy var tableTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Мои записи"
        label.font = UIFont(name: "Inter-Regular", size: 14)
        return label
    } ()
    
    private lazy var searchButton : UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(searchTapAction), for: .touchUpInside)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return button
    } ()
    private lazy var backgroundColorView : UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
   
        self.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        contentView.addSubview(searchButton)

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
        self.addSubview(self.fifthImage)
        self.addSubview(backgroundColorView)
        self.addSubview(tableTitleLabel)
        self.addSubview(searchButton)

    }
    
    
    private func setConstraints () {
        
        NSLayoutConstraint.activate([
        
            self.photoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.photoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 12),
            
            self.iconImage.centerYAnchor.constraint(equalTo: self.photoLabel.centerYAnchor),
            self.iconImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            self.iconImage.heightAnchor.constraint(equalToConstant: 24),
            self.iconImage.widthAnchor.constraint(equalToConstant: 24),
            
            self.firstImage.topAnchor.constraint(equalTo: self.photoLabel.bottomAnchor, constant: 12),
            self.firstImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            self.firstImage.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4),
            self.firstImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),

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
            self.fourthImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
           
            self.fifthImage.topAnchor.constraint(equalTo: self.firstImage.topAnchor),
            self.fifthImage.leadingAnchor.constraint(equalTo: self.fourthImage.trailingAnchor, constant: 8),
            self.fifthImage.widthAnchor.constraint(equalTo: self.firstImage.widthAnchor),
            self.fifthImage.heightAnchor.constraint(equalTo: firstImage.heightAnchor, multiplier: 1),
        ])
        backgroundColorView.snp.makeConstraints { make in
            make.top.equalTo(firstImage.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundColorView.snp.top).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(backgroundColorView.snp.bottom).offset(-8)
        }
        
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(tableTitleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
        }
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
        self.fifthImage.image = viewModel[3]
    }
    
    @objc func searchTapAction() {
        buttonTapCallback() 
    }
}
