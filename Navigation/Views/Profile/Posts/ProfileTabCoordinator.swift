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
    let user = User(login: "test", fullName: "Тестанутый Тестамес", image: UIImage(named: "cat")!, status: "Я тебя тестирую на наличие багов")

    
    enum Event {
        case tapLoginButton
        case tapShowStatus
        case logOut
    }
    
    func eventOccured(event: Event) {
        switch event {
        case .tapLoginButton:
            print("event login")
           
//            rootViewController.pushViewController(ProfileViewController(viewModel: profileVM), animated: false)

        case .tapShowStatus:
            print("tapped show status")
        case .logOut:
            print("Loged out event")
            rootViewController.popToRootViewController(animated: true)
        }
  
    }
    
   
    
    func start () {
        let profileVM = ProfileViewModel(user: user)
        let userDefault = UserDefaults.standard
        
        if userDefault.bool(forKey: "hasLogedIn")  { //Auth.auth().currentUser == nil
            rootViewController = UINavigationController(rootViewController: ProfileViewController(viewModel: profileVM))
        }
        else {
            rootViewController = UINavigationController(rootViewController: LogInViewController())        }
    }
}


