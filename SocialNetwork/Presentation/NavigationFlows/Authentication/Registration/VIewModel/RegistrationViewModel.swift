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
    }
    
    enum ViewInput {
        case openScreenConfirmation
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
        case .openScreenConfirmation:
            
            // отправка номера в firebase и ответ от сервера
            
            
            // номер валидный и регистрация прошла открывается окно для ввода данных -> передаю номер юзера
            coordinator?.setupConfirmationView()
        }
    }
    
}
