//
//  MainViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 14.3.24..
//

import Foundation

// MARK: - MainViewModelProtocol

protocol MainViewModelProtocol: ViewModelProtocol where State == MainState, ViewInput == MainViewInput {}

// MARK: - Associated enums

enum MainState {
    case initial
}

enum MainViewInput {
    
}

// MARK: - MainViewModel

final class MainViewModel: MainViewModelProtocol {
    
    // MARK: State related properties
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {

    }
    
}
