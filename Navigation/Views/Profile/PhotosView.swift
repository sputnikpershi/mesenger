//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Krime Loma    on 8/17/22.
//

import UIKit
import SnapKit

class PhotosView: UIView {

    var buttonTapCallback: () -> ()  = { }
    weak var viewModel: ProfileViewModel?
    var numberItems = 10
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset =  UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 16)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(AlbomCell.self, forCellWithReuseIdentifier: "cell")
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()

    private lazy var photoLabel : UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        let localizationText = NSLocalizedString("profile-photo-title", comment: "")
        label.text = localizationText
        label.textColor = .black
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
  
     lazy var tableTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Мои записи"
        label.font = UIFont(name: "Inter-Regular", size: 14)
        return label
    } ()
    
     lazy var searchButton : UIButton = {
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
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews () {
        self.addSubview(self.photoLabel)
        self.addSubview(self.iconImage)
        self.addSubview(self.collectionView)
        self.addSubview(backgroundColorView)
        self.addSubview(tableTitleLabel)
        self.addSubview(searchButton)

    }
    
    
    private func setConstraints () {
        
        photoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)

        }
        iconImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.height.width.equalTo(20)
            make.top.equalToSuperview().offset(12)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(photoLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        
        
        backgroundColorView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(28)
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
    
    
   
    
    @objc func searchTapAction() {
        buttonTapCallback() 
    }
}

extension PhotosView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            numberItems
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbomCell
            cell.setCell(index: indexPath.row + 1)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100, height: 80)
        }
    
    
}
