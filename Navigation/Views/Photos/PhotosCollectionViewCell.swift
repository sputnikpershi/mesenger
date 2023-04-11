//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Krime Loma    on 8/18/22.
//

import UIKit


class PhotosCollectionViewCell: UICollectionViewCell {
    
    var startTime: TimeInterval = 0
    
    private lazy var photoImage : UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setViews() {
        self.addSubview(self.photoImage)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.photoImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.photoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.photoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.photoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    
    func setup(with image: [UIImage], index: Int) {
        self.photoImage.image = image[index]
    }
}
