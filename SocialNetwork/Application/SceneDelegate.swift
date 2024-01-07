//
//  SceneDelegate.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 23.11.23..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var rootCoordinator = RootCoordinatorImp()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        window = UIWindow(windowScene: windowScene)
        
        let rootNavController = UINavigationController()
        rootCoordinator.navigationController = rootNavController
        rootCoordinator.start()
        
        window?.rootViewController = rootNavController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}

