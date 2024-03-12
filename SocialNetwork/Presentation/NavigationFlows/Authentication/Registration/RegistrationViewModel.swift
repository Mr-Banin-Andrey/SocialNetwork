//
//  RegistrationViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//

import Foundation

protocol RegistrationViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((RegistrationViewModel.State) -> Void)? { get set }
    func updateState(viewInput: RegistrationViewModel.ViewInput)
}

final class RegistrationViewModel: RegistrationViewModelProtocol {
    
    enum State {
        case initial
        case showOpenConfirmation
    }
    
    enum ViewInput {
        case openScreenConfirmation
    }
    
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .openScreenConfirmation:
            state = .showOpenConfirmation
        }
    }
    
}
