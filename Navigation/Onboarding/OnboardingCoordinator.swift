//
//  OnboardingCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit
import SwiftUI
import Combine

class OnboardingCoordinator : Coordinator {
    
    var rootViewController = UIViewController()
    let hasSeenOnboarding :  CurrentValueSubject<Bool, Never>
    
    init(hasSeenOnboarding: CurrentValueSubject<Bool, Never>) {
        self.hasSeenOnboarding  = hasSeenOnboarding
    }

    
    func start() {
        let view = OnboardingView { [weak self] in
            self?.hasSeenOnboarding.send(true)
        }
        rootViewController = UIHostingController(rootView: view)
    }
}
