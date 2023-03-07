//
//  FriendsCell.swift
//  Navigation
//
//  Created by Kiryl Rakk on 6/3/23.
//

import UIKit

class FriendsCell: UICollectionViewCell {

    
     var friendImage: UIImageView = {
        let image = UIImageView()
         image.layer.cornerRadius = 30
         image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayers()
    }
   
    
    func setLayers() {
        self.addSubview(friendImage)
        friendImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setLabels(index: Int) {
        friendImage.image = UIImage(named:maryAccount.friends[index].avatar )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
