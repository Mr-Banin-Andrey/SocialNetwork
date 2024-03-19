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
        do {
            let authenticationCoordinator = try appFactory.makeFlowCoordinator(.authentication, rootCoordinator: self)
            DispatchQueue.main.async {
                self.addChild(authenticationCoordinator)
                authenticationCoordinator.start()
            }
        } catch {
            print(">>>>>")
        }
        
    }
    
    func startUserFlow() {
        do {
            let userCoordinator = try appFactory.makeFlowCoordinator(.main, rootCoordinator: self)
            DispatchQueue.main.async {
                
                self.addChild(userCoordinator)
                userCoordinator.start()
            }
        } catch {
            print(">>>>>")
        }
    }
    

    
}
