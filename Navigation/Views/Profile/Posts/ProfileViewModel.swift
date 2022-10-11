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
    
    
    init(user: User) {
        self.user = user
    }
    
    
    
    //1 Перенести логику координаторова на кнопки Показать статус
    //2 Перенести весь контент для хэдера, фото, постов
    //3 Перенести локику авторизациюю

    
}
