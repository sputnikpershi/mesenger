//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit

class MainCoordinator: Coordinator {
    var rootViewController = UITabBarController()
    
    var childCoordinators = [Coordinator]()
    
    init() {
        rootViewController.tabBar.tintColor = .systemBlue
        rootViewController.tabBar.backgroundColor = .systemGray6
    }
    
    func start() {
        let feedCoordinator = FeedTabCoordinator()
        feedCoordinator.start()
        self.childCoordinators.append(feedCoordinator)
        let feedVC = feedCoordinator.rootViewController
        let localizationTabFeed = NSLocalizedString("tab-feed", comment: "")
        feedVC.tabBarItem = UITabBarItem(title: localizationTabFeed, image: UIImage(systemName: "doc.append.rtl"), selectedImage: UIImage(systemName: "doc.append.fill.rtl"))
        
        let profileCoordinator = ProfileTabCoordinator()
        profileCoordinator.start()
        self.childCoordinators.append(profileCoordinator)
        let profileVC = profileCoordinator.rootViewController
        let localizationTabPost = NSLocalizedString("tab-post", comment: "")
        profileVC.tabBarItem = UITabBarItem(title: localizationTabPost, image: UIImage(systemName:  "person.circle"), selectedImage: UIImage(systemName:  "person.circle.fill"))
        
        let likeCoordinator = LikeCoordinator()
        likeCoordinator.start()
        self.childCoordinators.append(likeCoordinator)
        let likeVC = likeCoordinator.rootViewController
        let localizationTabLike = NSLocalizedString("tab-like", comment: "")
        likeVC.tabBarItem = UITabBarItem(title: localizationTabLike, image: UIImage(systemName:  "heart.square"), selectedImage: UIImage(systemName:  "heart.square.fill"))
        
        rootViewController.viewControllers = [profileVC, feedVC, likeVC]
    }
    
    
}
