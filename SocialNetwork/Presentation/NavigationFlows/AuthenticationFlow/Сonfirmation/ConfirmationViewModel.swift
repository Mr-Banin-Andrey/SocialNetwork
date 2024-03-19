//
//  ConfirmationViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//

import Foundation

// MARK: - ConfirmationViewModelProtocol

protocol ConfirmationViewModelProtocol: ViewModelProtocol where State == ConfirmationState, ViewInput == ConfirmationViewInput {}

// MARK: - Associated enums

enum ConfirmationState {
    case initial
    case showUser
}

enum ConfirmationViewInput {
    case registrationOnSocialNetwork // получает юзера
}

// MARK: - Associated enums

final class ConfirmationViewModel: ConfirmationViewModelProtocol {
    
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
        case .registrationOnSocialNetwork:
            state = .showUser
        }
    }
    
}
