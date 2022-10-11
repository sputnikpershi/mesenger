//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit

enum Event {
    case tapLoginButton1
    case tapLoginButton2
}

class FeedTabCoordinator: Coordinator {
    var rootViewController = UINavigationController()
    var viewModel = FeedViewModel()
    
    
    func eventOccured(event: Event) {
        switch event {
        case .tapLoginButton1:
            let vc = PostViewController()
            self.rootViewController.pushViewController(vc, animated: true)
            vc.title = viewModel.titleInfo
        case .tapLoginButton2:
            let vc = InfoViewController()
            self.rootViewController.pushViewController(vc, animated: true)
            vc.title = viewModel.titlePost

        }
    }
        
    func start () {
        viewModel.coordinator = self

        rootViewController.setViewControllers([FeedViewController(viewModel: viewModel)], animated: false)
    }
}

