//
//  FeedModel.swift
//  Navigation
//
//  Created by Krime Loma on 7/10/22.
//

import UIKit

final class FeedModel {
    let secretWord = "text"
    
    func check(word: String) -> Bool {
         if word != "" {
             return word == secretWord ? true : false
         }
         return false
    }
}
