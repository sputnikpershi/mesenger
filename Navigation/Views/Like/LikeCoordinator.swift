//
//  LikeCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 2/12/22.
//

import UIKit
class LikeCoordinator: Coordinator {
    var rootViewController = UINavigationController()
   
    func start() {
        rootViewController.setViewControllers([LikeVController()], animated: false)
    }
}


