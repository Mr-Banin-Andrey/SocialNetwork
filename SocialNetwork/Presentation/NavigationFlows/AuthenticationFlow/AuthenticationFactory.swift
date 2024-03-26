//
//  AuthenticationFactory.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 12.3.24..
//

import UIKit

final class AuthenticationFactory {
    
    // MARK: Properties
    
    var rootCoordinator: AuthenticationCoordinator?
    
    //MARK: Public methods
    
    func makeLogInView() -> any UIViewController & Coordinatable {
        let viewModel = LogInViewModel()
        let viewController = LogInViewController(viewModel: viewModel)
        return viewController
    }

    func makeRegistrationView() -> any UIViewController & Coordinatable  {
        let viewModel = RegistrationViewModel()
        let viewController = RegistrationViewController(viewModel: viewModel)
        return viewController
    }

    func makeConfirmationView() -> any UIViewController & Coordinatable {
        let viewModel = ConfirmationViewModel()
        let viewController = ConfirmationViewController(viewModel: viewModel)
        return viewController
    }

    func makeHaveAccountView() -> any UIViewController & Coordinatable {
        let viewModel = HaveAccountViewModel()
        let viewController = HaveAccountViewController(viewModel: viewModel)
        return viewController
    }
    
    //MARK: Types
}
