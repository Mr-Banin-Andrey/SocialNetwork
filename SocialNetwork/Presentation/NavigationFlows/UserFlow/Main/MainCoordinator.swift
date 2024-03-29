//
//  MainCoordinator.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 14.3.24..
//

import UIKit

final class MainCoordinator: Coordinator {
   
    // MARK: Properties
    
    var parentCoordinator: (any Coordinator)?
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    
    private let userFactory: UserFactory
    
    init(userFactory: UserFactory) {
        self.navigationController = UINavigationController()
        self.userFactory = userFactory
    }
    
    //MARK: Methods
    
    func start() {
        let mainViewController = userFactory.makeMainScreen()
        (mainViewController as? MainViewController)?.coordinator = self
        navigationController.setViewControllers([mainViewController], animated: true)
        setupNavBarAppearance()
    }
    
    private func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .mainBackgroundColor
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.textAndButtonColor]
        
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController.navigationBar.isHidden = true
    }
    
    // MARK: Types
    
    typealias Destination = Never
}
