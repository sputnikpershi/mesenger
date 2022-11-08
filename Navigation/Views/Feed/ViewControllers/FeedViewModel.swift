//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import Foundation

class FeedViewModel {
    weak var coordinator: FeedTabCoordinator?
    private let secretWord = "text"
    let titlePost = "First screen"
    let titleInfo = "Second screen"
    
  
    func check(word: String) -> Bool {
        if word != "" {
            return word == secretWord ? true : false
        }
        return false
    }
}
