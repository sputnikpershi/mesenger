//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 9/10/22.
//

import UIKit
import SwiftUI
import Combine

class ApplicationCoordinator: Coordinator {
    var window: UIWindow
    var childCoordinator = [Coordinator]()
   
    init (window: UIWindow) {
        self.window = window
    }
    
    
    
    func start() {
        let mainCoordinator  = MainCoordinator()
        mainCoordinator.start()
        self.childCoordinator = [mainCoordinator]
        self.window.rootViewController = mainCoordinator.rootViewController
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
    



