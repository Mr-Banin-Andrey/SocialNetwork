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
    case showOpenConfirmation
}

enum RegistrationViewInput {
    case openScreenConfirmation(String)
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
        case .openScreenConfirmation(let phone):
            
            authenticationUseCase.registrationSendingCodeToPhone(phone: phone) { [weak self] (result: Result<Void, AuthenticationService.AuthenticationError>) in
                switch result {
                case .success(_):
                    self?.state = .showOpenConfirmation
                case .failure(let failure):
                    print("error registrationSendingCodeToPhone: \(failure)")
                }
            }
        }
    }
    
}
