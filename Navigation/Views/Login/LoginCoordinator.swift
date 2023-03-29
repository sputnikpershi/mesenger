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

    func start () {
        let vc = LogInViewController()
        rootViewController = UINavigationController(rootViewController: vc  )
    }
}

