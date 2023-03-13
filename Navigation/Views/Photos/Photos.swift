//
//  Photos.swift
//  Navigation
//
//  Created by Krime Loma    on 8/17/22.
//

import UIKit

struct Photos {
    var image: String
}

 enum Constants {
    static let numberOfItemsInLine : CGFloat = 3
}

func convertFromStringToPhotos (with array : [String] ) -> [UIImage]{
    var arrayPhotos : [UIImage] = []
    for i in 0..<array.count {
        let image = array[i]
        arrayPhotos.append(UIImage(named: image)!)
    }
    return arrayPhotos
}

 
var photoGallery = Array(1...15).map { String($0)}
var photosArray  = convertFromStringToPhotos(with: photoGallery)
var PhotoArray = photoGallery.map { Photos(image: $0)}
var photosArrayUIImage : [UIImage] = []

