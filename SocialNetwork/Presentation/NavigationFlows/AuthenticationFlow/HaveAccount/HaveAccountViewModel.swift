//
//  HaveAccountViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//

import Foundation

// MARK: - HaveAccountViewModelProtocol

protocol HaveAccountViewModelProtocol: ViewModelProtocol where State == HaveAccountState, ViewInput == HaveAccountViewInput {}

// MARK: - Associated enums

enum HaveAccountState {
    case initial
    case showUser(User)
    case showAlertError
    case openScreenForgotPassword
}

enum HaveAccountViewInput {
    case didTapSignIn(email: String, password: String)
    case didTapForgotPassword
}

// MARK: - HaveAccountViewModel

final class HaveAccountViewModel: HaveAccountViewModelProtocol {
    
    // MARK: State related properties
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    @Dependency private var authenticationUseCase: AuthenticationUseCase
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {

        case .didTapSignIn(email: let email, password: let password):
            
            authenticationUseCase.signIn(email: email, password: password) { [weak self] (result:Result<User, AuthenticationService.AuthenticationError>) in
                guard let self else { return }
                switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self.state = .showUser(user)
                    }
                case .failure(let failure):
                    DispatchQueue.main.async {
                        self.state = .showAlertError
                        print("Error signIn: ... \(failure)")
                    }
                }
            }
        case .didTapForgotPassword:
            state = .openScreenForgotPassword
        }
    }
    
}
