//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import Foundation


final class ProfileViewModel {
    weak var coordinator: ProfileTabCoordinator?
    var account : Account
    var friends: [FriendProfile]?
    var comments = [Comments]()
    var footerText = "Вы несете ответсвенность за каждое слово в публичном пространстве."
    init(account: Account, friends: [FriendProfile]? = nil ) {
        self.account = account
        self.friends = friends
    }
}
//    func findCommentsUser (idPost: String, date: Date, text : String) -> Account?{
//        //собираем все комментарии в одном месте
//        var account : Account?
//        let friends = self.friends ?? []
//        for i in 0..<friends.count {
//            let comments = friends[i].account.comments
//            for j in comments {
//                if j.idPost == idPost && j.commentText == text && j.date == date {
//                    account = friends[i].account
//                }
//            }
//        }
//
//        // Узнаем пользователя комментария
//        return account
//    }
//}

enum ProfileState {
    case mainProfile
    case friendsProfile
}




