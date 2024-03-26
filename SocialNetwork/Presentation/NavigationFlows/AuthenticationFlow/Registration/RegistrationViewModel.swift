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
    case openScreenConfirmation
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
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .openScreenConfirmation:
            state = .showOpenConfirmation
        }
    }
    
}
