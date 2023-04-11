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
    var seatchText: String?
    
    var footerText = "Вы несете ответсвенность за каждое слово в публичном пространстве."
    init(account: Account, friends: [FriendProfile]? = nil ) {
        self.account = account
        self.friends = friends
    }
    
    
    
    func returnAccountPosts() -> [AccountPosts] {
        var accountPosts =  [AccountPosts]()
        for i in account.posts {
            let post = i
            post.authorLabel = account.name + " " + account.surname
            post.authorImage = account.avatar
            post.statusLabel = account.status
            accountPosts.append(post)
        }
        return accountPosts
    }
    
    func returnFriendsPosts () -> [AccountPosts] {
        var friendsPosts = [AccountPosts]()
        for friend in friends ?? [] {
            let posts = friend.account.posts
            for j in posts {
                let post = j
                post.authorLabel = friend.account.name + " " + friend.account.surname
                post.authorImage = friend.account.avatar
                post.statusLabel = friend.account.status
                friendsPosts.append(post)
            }
        }
        //        friendsPosts = friendsPosts.sorted(by: { post1, post2 in
        //            post1.date > post2.date
        //        })
        return friendsPosts
    }
    
    func returnAllPost () -> [AccountPosts] {
        var allPost =  [AccountPosts]()
        
        for i in account.posts {
            let post = i
            post.authorLabel = account.name + " " + account.surname
            post.authorImage = account.avatar
            post.statusLabel = account.status
            allPost.append(post)
        }
        
        for friend in friends ?? [] {
            let posts = friend.account.posts
            for j in posts {
                let post = j
                post.authorLabel = friend.account.name + " " + friend.account.surname
                post.authorImage = friend.account.avatar
                post.statusLabel = friend.account.status
                allPost.append(post)
            }
        }
        
        //        allPost = allPost.sorted(by: { post1, post2 in
        //            post1.date > post2.date
        //        })
        
        return allPost
    }
    
    
    func searchAccountPosts(searchText: String? = nil) -> [AccountPosts]{
        var postArray = [AccountPosts]()
        let allPosts = returnAllPost()
        if let searchText    {
            for post in allPosts {
                if post.descriptionLabel.contains(searchText ) {
                    postArray.append(post)
                }
            }
        } else {
            postArray = allPosts
        }
        return postArray
    }
    
    func findAccountWithPost( post: AccountPosts) -> Account {
        var accounts: [Account] = []
        var accountWithPost = Account(nickname: "", name: "", surname: "", status: "", sex: .female, dateBirth: Date(), hometown: "", posts: [], comments: [])
        friends?.forEach({ friend in
            accounts.append(friend.account)
        })
        for account in accounts {
            for pos in account.posts {
                if pos.descriptionLabel == post.descriptionLabel {
                    accountWithPost = account
                }
            }
        }
        return accountWithPost
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



