//
//  HaveAccountViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//

import Foundation

protocol HaveAccountViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((HaveAccountViewModel.State) -> Void)? { get set }
    func updateState(viewInput: HaveAccountViewModel.ViewInput)
}

final class HaveAccountViewModel: HaveAccountViewModelProtocol {
    
    enum State {
        case initial
    }
    
    enum ViewInput {
        case goToScreenMain // получает юзера
    }
    
    weak var coordinator: RootCoordinator?
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .goToScreenMain:
            
            // передаёт юзера
            coordinator?.startUser() // принмает юзера
        }
    }
    
}
