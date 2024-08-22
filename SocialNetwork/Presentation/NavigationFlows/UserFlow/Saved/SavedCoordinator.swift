//
//  SavedCoordinator.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 17.3.24..
//

import UIKit

final class SavedCoordinator: Coordinator {
   
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
        let savedViewController = userFactory.makeSavedScreen()
        (savedViewController as? SavedViewController)?.coordinator = self
        navigationController.setViewControllers([savedViewController], animated: true)
    }
    
    
    // MARK: Types
    
    typealias Destination = Never
}
