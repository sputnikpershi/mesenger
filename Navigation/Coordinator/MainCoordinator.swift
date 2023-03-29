//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit
import FirebaseAuth
class MainCoordinator: Coordinator {
    var rootViewController = UITabBarController()
    
    var childCoordinators = [Coordinator]()
    
    init() {
        rootViewController.tabBar.tintColor = .orange
        rootViewController.tabBar.backgroundColor = .systemGray6
    }
    
    func start() {
       
        let homeCoordinator = HomeTabCoordinator()
        homeCoordinator.start()
        self.childCoordinators.append(homeCoordinator)
        let feedVC = homeCoordinator.rootViewController
        let localizationTabFeed = NSLocalizedString("tab-feed", comment: "")
        feedVC.tabBarItem = UITabBarItem(title: localizationTabFeed, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        
        let profileCoordinator = ProfileTabCoordinator()
        profileCoordinator.start()
        self.childCoordinators.append(profileCoordinator)
        let profileVC = profileCoordinator.rootViewController
        let localizationTabPost = NSLocalizedString("tab-post", comment: "")
        profileVC.tabBarItem = UITabBarItem(title: localizationTabPost, image: UIImage(systemName:  "person.circle"), selectedImage: UIImage(systemName:  "person.circle"))
        
        let likeCoordinator = LikeCoordinator()
        likeCoordinator.start()
        self.childCoordinators.append(likeCoordinator)
        let likeVC = likeCoordinator.rootViewController
        let localizationTabLike = NSLocalizedString("tab-like", comment: "")
        likeVC.tabBarItem = UITabBarItem(title: localizationTabLike, image: UIImage(systemName:  "heart"), selectedImage: UIImage(systemName:  "heart"))
        
        rootViewController.viewControllers = [feedVC , profileVC, likeVC]
    }
}
