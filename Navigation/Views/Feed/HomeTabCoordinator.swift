//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Kiryl Rakk on 11/10/22.
//

import UIKit


class HomeTabCoordinator: Coordinator {
    var rootViewController = UINavigationController()
    
    func start () {
        let layout = UICollectionViewFlowLayout()
        rootViewController = UINavigationController(rootViewController:   HomeViewController(collectionViewLayout: layout))
    }
}

