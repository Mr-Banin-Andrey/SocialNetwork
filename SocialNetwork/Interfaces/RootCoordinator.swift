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
    func startUser()
    func setupRegistrationView()
    func setupConfirmationView()
    func setupHaveAccountView()
}


final class RootCoordinatorImp: RootCoordinator {
    
    var navigationController: UINavigationController?
    
    func start() {
        setupLogInView()
    }
    
    func startUser() {
        print("1")
    }
    
    func setupLogInView() {
        let viewModel = LogInViewModel()
        viewModel.coordinator = self
        let viewController = LogInViewController(viewModel: viewModel)
        navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func setupRegistrationView() {
        let viewModel = RegistrationViewModel()
        viewModel.coordinator = self
        let viewController = RegistrationViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupConfirmationView() {
        let viewModel = ConfirmationViewModel()
        viewModel.coordinator = self
        let viewController = ConfirmationViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupHaveAccountView() {
        let viewModel = HaveAccountViewModel()
        viewModel.coordinator = self
        let viewController = HaveAccountViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
