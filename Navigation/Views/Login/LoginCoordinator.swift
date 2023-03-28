//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 28/3/23.
//

import UIKit
import Combine
class LoginCoordinator: Coordinator {
    var rootViewController = UINavigationController()
//    var hasSeenLogIn : CurrentValueSubject<Bool, Never>
//    init (hasSeenLogIn:CurrentValueSubject<Bool,Never>) {
//        self.hasSeenLogIn  = hasSeenLogIn
//    }
    func start () {
        let vc = LogInViewController()
        rootViewController = UINavigationController(rootViewController: vc  )
    }
}

