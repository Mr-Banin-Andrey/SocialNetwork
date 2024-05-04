//
//  AuthenticationCoordinator.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 12.3.24..
//

import UIKit

final class AuthenticationCoordinator: Coordinator {
    
    //MARK: Properties
    
    weak var parentCoordinator: (any Coordinator)?
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    
    private let authenticationFactory: AuthenticationFactory
    
    //MARK: Init
    
    init(navigationController: UINavigationController) throws {
        self.navigationController = navigationController
        
        let authenticationUseCase = AuthenticationUseCase()
        self.authenticationFactory = AuthenticationFactory(authenticationUseCase: authenticationUseCase)
        self.authenticationFactory.rootCoordinator = self
    }
    
    //MARK: Public methods
    
    func start() {
        let loginVC = authenticationFactory.makeLogInView()
        (loginVC as? LogInViewController)?.coordinator = self
        navigationController.setViewControllers([loginVC], animated: true)
        setupNavBarAppearance()
    }
    
    func proceedToUserFlow(_ user: User) {
        stop()
        (parentCoordinator as? RootCoordinator)?.startUserFlow(user)
        navigationController.navigationBar.isHidden = true
    }
    
    private func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .mainBackgroundColor
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.textAndButtonColor]
        navBarAppearance.configureWithTransparentBackground()
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController.navigationBar.isHidden = true
    }
    
    // MARK: Types
    
    enum Destination: DestinationProtocol {
        case registration(coordinator: AuthenticationCoordinator)
//        case confirmation(coordinator: AuthenticationCoordinator, phone: String)
        case haveAccount(coordinator: AuthenticationCoordinator)
        
        var module: any UIViewController & Coordinatable {
            switch self {
            case .registration(let coordinator):
                let registrationVC = coordinator.authenticationFactory.makeRegistrationView()
                (registrationVC as? RegistrationViewController)?.coordinator = coordinator
                return registrationVC
//            case .confirmation(let coordinator, let phone):
//                let confirmationVC = coordinator.authenticationFactory.makeConfirmationView(phone: phone)
//                (confirmationVC as? ConfirmationViewController)?.coordinator = coordinator
//                return confirmationVC
            case .haveAccount(let coordinator):
                let haveAccountVC = coordinator.authenticationFactory.makeHaveAccountView()
                (haveAccountVC as? HaveAccountViewController)?.coordinator = coordinator
                return haveAccountVC
            }
        }
    }
}
