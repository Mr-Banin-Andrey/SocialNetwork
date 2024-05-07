//
//  LogInViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.1.24..
//

import Foundation

// MARK: - LogInViewModelProtocol

protocol LogInViewModelProtocol: ViewModelProtocol where State == LogInState, ViewInput == LogInViewInput {}

// MARK: - Associated enums

enum LogInState {
    case initial
    case showOpenRegistration
    case showOpenHaveAccount
    case tryingToSignIn
    case showUser(User)
}

enum LogInViewInput {
    case openScreenRegistration
    case openScreenHaveAccount
    case willCheckUser
}

// MARK: - LogInViewModel

final class LogInViewModel: LogInViewModelProtocol {
    
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
        case .openScreenRegistration:
            state = .showOpenRegistration
        case .openScreenHaveAccount:
            state = .showOpenHaveAccount
        case .willCheckUser:
            state = .tryingToSignIn
            authenticationUseCase.authUser { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self.state = .showUser(user)
                    }
                case .failure(let failure):
                    DispatchQueue.main.async {
                        print("Error signIn: ... \(failure)")
                        self.state = .initial
                    }
                }
            }
        }
    }
}
