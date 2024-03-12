//
//  ConfirmationViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//

import Foundation

protocol ConfirmationViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((ConfirmationViewModel.State) -> Void)? { get set }
    func updateState(viewInput: ConfirmationViewModel.ViewInput)
}

final class ConfirmationViewModel: ConfirmationViewModelProtocol {
    
    enum State {
        case initial
    }
    
    enum ViewInput {
        case registrationOnSocialNetwork // получает юзера
    }
        
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    func updateState(viewInput: ViewInput) {
//        switch viewInput {
//        case .registrationOnSocialNetwork:
//            
//            // передаёт юзера
//            coordinator?.startUser() // принмает юзера
//        }
    }
    
}
