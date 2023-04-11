//
//  SideMenuModel.swift
//  Navigation
//
//  Created by Kiryl Rakk on 17/3/23.
//

import UIKit


enum StateMenu {
    case menuAction
    case moreInfoAction
}

enum MenuButtons: String, CaseIterable {
    case bookmark = "Закладки"
    case likes = "Понравилось"
    case files = "Файлы"
    case archives = "Архивы"
    case mainInfo = "Основная информация"
    case contacts = "Контакты"
    case interests = "Интересы"
    case education = "Образование"
    case job = "Карьера"
    
    
    var image : String  {
        switch self {
        case MenuButtons.bookmark:
            return "star"
        case .likes:
            return "heart"
        case .files:
            return "tray.and.arrow.up"
        case .archives:
            return "link"
        default:
            return ""
        }
        
    }
}
