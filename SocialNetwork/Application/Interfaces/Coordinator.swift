//
//  Coordinator.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 12.3.24..
//

import UIKit

protocol Coordinator: AnyObject {
    associatedtype Destination: DestinationProtocol
    
    var parentCoordinator: (any Coordinator)? { get set }
    var childCoordinators: [any Coordinator] { get set }
    var navigationController: UINavigationController { get }
    
    func start()
    func stop()
    func navigateTo(_ destination: Destination)
    func addChild(_ childCoordinator: any Coordinator)
    func removeChild(_ childCoordinator: any Coordinator)
}

extension Coordinator {
    
    func stop() {
        parentCoordinator?.removeChild(self)
    }
    
    func navigateTo(_ destination: Destination) {
        navigationController.pushViewController(destination.module, animated: true)
    }
    
    func addChild(_ childCoordinator: any Coordinator) {
        childCoordinator.parentCoordinator = self
        childCoordinators.append(childCoordinator)
    }
    
    func removeChild(_ childCoordinator: any Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === childCoordinator {
                childCoordinators.remove(at: index)
                break
            } else {
                print(">>> error removeChild")
            }
        }
    }
}


protocol DestinationProtocol {
    var module: any UIViewController & Coordinatable { get }
}

extension Never: DestinationProtocol {
    var module: any UIViewController & Coordinatable {
        fatalError()
    }
}
