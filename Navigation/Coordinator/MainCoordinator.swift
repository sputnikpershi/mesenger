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
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "doc.append.rtl"), selectedImage: UIImage(systemName: "doc.append.fill.rtl"))
        
        
        let profileCoordinator = ProfileTabCoordinator()
        profileCoordinator.start()
        self.childCoordinators.append(profileCoordinator)
        let profileVC = profileCoordinator.rootViewController
        profileVC.tabBarItem = UITabBarItem(title: "Post", image: UIImage(systemName:  "person.circle"), selectedImage: UIImage(systemName:  "person.circle.fill"))
        
        rootViewController.viewControllers = [feedVC, profileVC]
    }
    
    
}
