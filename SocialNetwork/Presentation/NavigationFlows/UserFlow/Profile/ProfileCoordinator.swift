//
//  ProfileCoordinator.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 17.3.24..
//

import UIKit

final class ProfileCoordinator: Coordinator {
   
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
        let profileViewController = userFactory.makeProfileScreen()
        (profileViewController as? ProfileViewController)?.coordinator = self
        navigationController.setViewControllers([profileViewController], animated: true)
    }
    
    
    // MARK: Types
    
    typealias Destination = Never
}
