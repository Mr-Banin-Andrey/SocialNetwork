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
}

enum LogInViewInput {
    case openScreenRegistration
    case openScreenHaveAccount
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
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .openScreenRegistration:
            state = .showOpenRegistration
        case .openScreenHaveAccount:
            state = .showOpenHaveAccount
        }
    }
}
