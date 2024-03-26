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
    case showUser
}

enum HaveAccountViewInput {
    case goToScreenMain // получает юзера
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
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .goToScreenMain:
            state = .showUser
        }
    }
    
}
