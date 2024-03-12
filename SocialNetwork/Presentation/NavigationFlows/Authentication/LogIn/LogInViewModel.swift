//
//  LogInViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.1.24..
//

import Foundation

protocol LogInViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((LogInViewModel.State) -> Void)? { get set }
    func updateState(viewInput: LogInViewModel.ViewInput)
}

final class LogInViewModel: LogInViewModelProtocol {
    
    enum State {
        case initial
        case showOpenRegistration
        case showOpenHaveAccount
    }
    
    enum ViewInput {
        case openScreenRegistration
        case openScreenHaveAccount
    }
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .openScreenRegistration:
            state = .showOpenRegistration
        case .openScreenHaveAccount:
            state = .showOpenHaveAccount
        }
    }
    
}
