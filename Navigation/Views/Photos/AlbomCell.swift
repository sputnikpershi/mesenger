//
//  AlbomCollectionViewCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 12/3/23.
//

import UIKit
import SnapKit

class AlbomCell: UICollectionViewCell {
    
    private lazy var albomImage : UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(albomImage)
        albomImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setCell(index: Int) {
        albomImage.image = UIImage(named: "\(index)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

