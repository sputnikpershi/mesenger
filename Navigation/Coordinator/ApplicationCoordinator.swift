//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 9/10/22.
//

import UIKit
import SwiftUI
import FirebaseAuth

class ApplicationCoordinator: Coordinator {
    var window: UIWindow
    var childCoordinator = [Coordinator]()
  
    init (window: UIWindow) {
        self.window = window
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "dissmis"), object: nil)
    }
    
    @objc func loadList(notification: NSNotification){
        let mainCoordinator  = MainCoordinator()
        mainCoordinator.start()
        self.childCoordinator = [mainCoordinator]
        self.window.rootViewController = mainCoordinator.rootViewController
    }
    
    
    func start() {
        if Auth.auth().currentUser == nil {
            let loginCoordinator = LoginCoordinator()
            loginCoordinator.start()
            self.childCoordinator  = [loginCoordinator]
            self.window.rootViewController = loginCoordinator.rootViewController
        } else {
            let mainCoordinator  = MainCoordinator()
            mainCoordinator.start()
            self.childCoordinator = [mainCoordinator]
            self.window.rootViewController = mainCoordinator.rootViewController
        }
    }
}




























    //    setupOnboardingValue() // работа над онбордингом

//
//        hasSeenOnboarding
//            .removeDuplicates()
//            .sink { [weak self] hasSeen in
//
//            if hasSeen {
//                let mainCoordinator  = MainCoordinator()
//                mainCoordinator.start()
//                self?.childCoordinator = [mainCoordinator]
//                self?.window.rootViewController = mainCoordinator.rootViewController
//            } else if let hasSeenOnboarding = self?.hasSeenOnboarding {
//                let onboardingCoordinator = OnboardingCoordinator(hasSeenOnboarding: hasSeenOnboarding)
//                onboardingCoordinator.start()
//                self?.childCoordinator = [onboardingCoordinator]
//                self?.window.rootViewController = onboardingCoordinator.rootViewController
//
//            }
//        }.store(in: &subscriptions)
        
    
    
    
    
//
//    func setupOnboardingValue () {
//        let key = "hasSeenOnboarding"
//        let value = UserDefaults.standard.bool(forKey: key)
//        hasSeenOnboarding.send(value)
//
//        hasSeenOnboarding
//            .filter { $0 }
//            .sink{ value in
//                UserDefaults.standard.setValue(value, forKey: key)
//            }.store(in: &subscriptions)
//    }
    



