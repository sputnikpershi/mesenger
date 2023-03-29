//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit

class ProfileTabCoordinator: Coordinator {
    var rootViewController = UINavigationController()
    var firstLogin = false
    let account = profileMary.account
    let friends = profileMary.friends
    
    
    enum Event {
        case tapLoginButton
        case tapShowStatus
        case logOut
    }
    
    func eventOccured(event: Event) {
        switch event {
        case .tapLoginButton:
            print("event login")
        case .tapShowStatus:
            print("tapped show status")
        case .logOut:
            print("Loged out event")
            rootViewController.popToRootViewController(animated: true)
        }
    }
    
    
    
    func start () {
        let profileVM = ProfileViewModel(account: account, friends: friends)
        let profileVC = ProfileViewController(viewModel: profileVM)
        profileVC.isMainProfile = true
        rootViewController = UINavigationController(rootViewController:  profileVC )
    }
}

