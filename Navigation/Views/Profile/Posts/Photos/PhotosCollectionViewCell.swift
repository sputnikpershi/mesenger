//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Krime Loma    on 8/18/22.
//

import UIKit
import iOSIntPackage


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
        
        let imageProcessot = ImageProcessor()
        startTime = Date().timeIntervalSince1970
        
        imageProcessot.processImagesOnThread(sourceImages: [image[index]], filter: .bloom(intensity: 10), qos: .utility) { cgImage in DispatchQueue.main.sync {
            
            cgImage.forEach { cgImage in
                if let image = cgImage {
                    self.photoImage.image = UIImage(cgImage: image)
                }
            }
        }
            let endTime = Date().timeIntervalSince1970    // 1512538956.57195 seconds
            let elapsedTime = Float(endTime - self.startTime)
            print(elapsedTime)
            
        }
        
    }
    
}
