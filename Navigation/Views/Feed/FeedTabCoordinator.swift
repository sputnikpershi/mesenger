//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit


class FeedTabCoordinator: Coordinator {
    var rootViewController = UINavigationController()
    
    func start () {
        rootViewController.setViewControllers([FeedViewController()], animated: false)
    }
}

