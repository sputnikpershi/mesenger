//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import Foundation


final class ProfileViewModel {
    
    weak var coordinator: ProfileTabCoordinator?
    var user : User
    var footerText = "Вы несете ответсвенность за каждое слово в публичном пространстве."
    
    init(user: User) {
        self.user = user
    }

}
