//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit


class FeedTabCoordinator: Coordinator {
    var rootViewController = UINavigationController()
    var viewModel = FeedViewModel()
    
    
    func start () {
        viewModel.coordinator = self
        rootViewController.setViewControllers([FeedViewController()], animated: false)
    }
}

