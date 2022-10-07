//
//  FeedModel.swift
//  Navigation
//
//  Created by Krime Loma on 7/10/22.
//

import UIKit

final class FeedModel {
    var word: String
    let secretWord = "text"
    
    init(word: String) {
        self.word = word
    }
    
     func check() -> Bool {
         if word != "" {
             return word == secretWord ? true : false
         }
         return false
    }
}
