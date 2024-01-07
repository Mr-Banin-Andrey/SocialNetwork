//
//  RootCoordinator.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 7.1.24..
//

import UIKit

protocol Coordinatable {
    var coordinator: RootCoordinator? { get set }
}

protocol RootCoordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    func start()
    func setupRegistrationView()
    func setupHaveAccountView()
}


final class RootCoordinatorImp: RootCoordinator {
    
    var navigationController: UINavigationController?
    
    func start() {
        setupLogInView()
    }
    
    func setupLogInView() {
        let viewModel = LogInViewModel()
        viewModel.coordinator = self
        let viewController = LogInViewController(viewModel: viewModel)
        navigationController?.setViewControllers([viewController], animated: true)
    }
    
    func setupRegistrationView() {
        let viewController = ViewController()
        viewController.title = "setupRegistrationView"
        viewController.view.backgroundColor = .green
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupHaveAccountView() {
        let viewController = ViewController()
        viewController.title = "setupHaveAccountView"
        viewController.view.backgroundColor = .yellow
        navigationController?.present(viewController, animated: true)
    }
}
