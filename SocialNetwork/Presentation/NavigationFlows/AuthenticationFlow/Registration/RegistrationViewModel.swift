//
//  RegistrationViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//

import Foundation

// MARK: - RegistrationViewModelProtocol

protocol RegistrationViewModelProtocol: ViewModelProtocol where State == RegistrationState, ViewInput == RegistrationViewInput {}

// MARK: - Associated enums

enum RegistrationState {
    case initial
    case tryingToSignUp
    case showUser(User)
    case showAlertFieldsEmpty
    case showAlertPasswordsDoNotMatch
    case showAlertInvalidEmail
    case showAlertInvalidPassword
}

enum RegistrationViewInput {
    case didTapRegistration(email: String, password: String, user: User)
    case fieldsEmpty
    case passwordsDoNotMatch
}

// MARK: - RegistrationViewModel

final class RegistrationViewModel: RegistrationViewModelProtocol {
    
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
        case .didTapRegistration(let email,let password, let user):
            
            state = .tryingToSignUp
            
            guard ValidationCheck.emailCheck(email) else {
                state = .showAlertInvalidEmail
                return
            }
            
            guard ValidationCheck.passwordCheck(password) else {
                state = .showAlertInvalidPassword
                return
            }
            
            authenticationUseCase.signUp(email: email, password: password, user: user) { [weak self] result in
                switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self?.state = .showUser(user)
                    }
                case .failure(let failure):
                    print("Error createNewUser: ... \(failure)")
                }
            }
        case .fieldsEmpty:
            state = .showAlertFieldsEmpty
        case .passwordsDoNotMatch:
            state = .showAlertPasswordsDoNotMatch
        }
    }
}
