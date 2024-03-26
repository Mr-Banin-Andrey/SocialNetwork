//
//  UserCoordinator.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 13.3.24..
//

import UIKit

final class UserCoordinator: Coordinator {
    
    typealias Destination = Never

    //MARK: Properties
    
    weak var parentCoordinator: (any Coordinator)?
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    
    private let userFactory: UserFactory
    
    //MARK: Init
    
    init( navigationController: UINavigationController) throws {
        self.navigationController = navigationController
        
        self.userFactory = UserFactory()
    }
    
    func start() {
        let mainTabBar = userFactory.makeRootTabBar(parentCoordinator: self)
        navigationController.setViewControllers([mainTabBar], animated: true)
    }
}
