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

func convertFromStringToPhotos (with array : [String] ) -> [Photos]{
    var arrayPhotos : [Photos] = []
    for i in 0..<array.count {
        let image = array[i]
        arrayPhotos.append(Photos(image: image))
    }
    return arrayPhotos
}

 
var photoGallery = Array(1...20).map { String($0)}
var photosArray  = convertFromStringToPhotos(with: photoGallery)

