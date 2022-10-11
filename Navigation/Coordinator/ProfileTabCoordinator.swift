//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit

class ProfileTabCoordinator: Coordinator {
    var rootViewController = UINavigationController()
    
    enum Event {
        case tapLoginButton
        case tapShowStatus
    }
    
    func eventOccured(event: Event) {
        switch event {
        case .tapLoginButton:
            print("tapped login button")
        case .tapShowStatus:
            print("tapped show status")
        }
    }
    
    func start () {
        rootViewController.setViewControllers([LogInViewController()], animated: false)
    }
}
