//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit

class ProfileTabCoordinator: Coordinator {
    var rootViewController = UINavigationController()
    
    func start () {
        rootViewController.setViewControllers([LogInViewController()], animated: false)
    }
}

