//
//  RootCoordinator.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 7.1.24..
//

import UIKit

final class RootCoordinator: Coordinator {
    
    typealias Destination = Never
    
    var parentCoordinator: (any Coordinator)?
    var childCoordinators: [any Coordinator] = []
    var navigationController = UINavigationController()
    
    private var appFactory: AppFactoryProtocol = AppFactory()
    
    
    func start() {
        startLogInFlow()
    }
    
    func startLogInFlow() {
        guard let authenticationCoordinator = try? appFactory.makeFlowCoordinator(.authentication, rootCoordinator: self) else { return }
        addChild(authenticationCoordinator)
        authenticationCoordinator.start()
    }
    
    func startUserFlow() {
        
    }
    

    
}
