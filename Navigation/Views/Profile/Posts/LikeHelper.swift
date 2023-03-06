//
//  LikeHelper.swift
//  Navigation
//
//  Created by Kiryl Rakk on 27/1/23.
//

import Foundation

protocol LikeDelegate {
    func likePost(_  isLike: inout Bool)
}

class LikeHelper {
    
    var likeStatus : Bool?
    var delegate : LikeDelegate?
    
    func likePost(isLiked: inout Bool) {
        isLiked.toggle()
        delegate?.likePost(&isLiked)
        likeStatus = isLiked
    }
}



