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
    
    let authenticationUseCase: AuthenticationUseCase
    
    init(authenticationUseCase: AuthenticationUseCase) {
        self.authenticationUseCase = authenticationUseCase
        
        ///
        /// Здесь регистрируем в глобальный контейнер, чтобы ресолвить в экранах,
        /// которые создаются в координаторах глубже по иерархии навигации,
        /// которые не имеют доступа к фабрике, чтобы не было необходимости
        /// тянуть `AuthenticationUseCase` при каждом создании нового объекта.
        ///
        
        AppDIContainer.register(type: AuthenticationUseCase.self, authenticationUseCase)
    }
    
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

    func makeConfirmationView(phone: String) -> any UIViewController & Coordinatable {
        let viewModel = ConfirmationViewModel(phone: phone)
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
