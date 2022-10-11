//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Krime Loma    on 7/25/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var applicationCoordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
//
//        let feedController = UINavigationController(rootViewController: FeedViewController())
//
//
        
//
//        let loginVC = LogInViewController()
//        let myInspector = MyLoginFactory().makeLoginInspector()
//
//        loginVC.loginDelegate = myInspector
//        let loginController = UINavigationController(rootViewController: loginVC ) // LogInViewController()ProfileViewController
//
//        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = [feedController, loginController]
//        tabBarController.viewControllers?.enumerated().forEach{
//            $1.tabBarItem.title = $0 == 0 ? "Feed" : "Profile"
//            $1.tabBarItem.image = $0 == 0 ? UIImage(systemName: "doc.append.fill.rtl") : UIImage(systemName: "person.circle")
//
//        }
        
        let applicationCoordinator = ApplicationCoordinator(window: window!)
        applicationCoordinator.start()
        self.applicationCoordinator = applicationCoordinator
//        self.window?.rootViewController = applicationCoordinator.window.rootViewController

        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

