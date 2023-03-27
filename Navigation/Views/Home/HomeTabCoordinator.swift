//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit


class HomeTabCoordinator: Coordinator {
    var rootViewController = UINavigationController()
    let account = profileMary.account
    let friends = profileMary.friends
    
    func start () {
        let layout = UICollectionViewFlowLayout()
        let profileVM = ProfileViewModel(account: account, friends: friends)
        let homeVC = HomeViewController(collectionViewLayout: layout)
        homeVC.viewModel = profileVM
        rootViewController = UINavigationController(rootViewController: homeVC  )
    }
}

