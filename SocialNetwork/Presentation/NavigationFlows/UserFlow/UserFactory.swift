//
//  UserFactory.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 13.3.24..
//

import UIKit

final class UserFactory {
        
    //MARK: Public methods
    
    func makeRootTabBar(parentCoordinator: (any Coordinator)? = nil) -> UITabBarController {
        
        let mainCoordinator = MainCoordinator(userFactory: self)
        parentCoordinator?.addChild(mainCoordinator)
        mainCoordinator.start()
        let mainScreen = mainCoordinator.navigationController
        
        let profilenCoordinator = ProfileCoordinator(userFactory: self)
        parentCoordinator?.addChild(profilenCoordinator)
        profilenCoordinator.start()
        let profileScreen = profilenCoordinator.navigationController
        
        let savedCoordinator = SavedCoordinator(userFactory: self)
        parentCoordinator?.addChild(savedCoordinator)
        savedCoordinator.start()
        let savedScreen = savedCoordinator.navigationController
        
        let tabBarController = UserTabBar()
        
        tabBarController.viewControllers = [
            mainScreen,
            profileScreen,
            savedScreen
        ]
        return tabBarController
    }
    
    func makeMainScreen() -> any UIViewController & Coordinatable {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        let mainTitle = "Main"
        let mainTabBarItem = UITabBarItem(title: mainTitle, 
                                          image: .vectorHouseNotSelectImage.withRenderingMode(.alwaysOriginal),
                                          selectedImage: .vectorHouseSelectedImage.withRenderingMode(.alwaysOriginal))
        mainTabBarItem.tag = 0
        viewController.tabBarItem = mainTabBarItem
        return viewController
    }
    
    func makeProfileScreen() -> any UIViewController & Coordinatable {
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)
        let mainTitle = "Profile"
        let profileTabBarItem = UITabBarItem(title: mainTitle,
                                             image: .profileIconNotSelectImage.withRenderingMode(.alwaysOriginal),
                                             selectedImage: .profileIconSelectedImage.withRenderingMode(.alwaysOriginal))
        profileTabBarItem.tag = 1
        viewController.tabBarItem = profileTabBarItem
        return viewController
    }
    
    func makeSavedScreen() -> any UIViewController & Coordinatable {
        let viewModel = SavedViewModel()
        let viewController = SavedViewController(viewModel: viewModel)
        let mainTitle = "Saved"
        let mainTabBarItem = UITabBarItem(title: mainTitle,
                                          image: .savedIconImage.withRenderingMode(.alwaysOriginal),
                                          selectedImage: .savedIconImage)
        mainTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        mainTabBarItem.tag = 2
        viewController.tabBarItem = mainTabBarItem
        return viewController
    }
    
}
