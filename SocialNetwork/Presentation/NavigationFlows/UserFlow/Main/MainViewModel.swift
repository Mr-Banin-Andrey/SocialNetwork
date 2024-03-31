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
    case openScreenSubscriber
    case openScreenMenu
    case openScreenPost
}

enum MainViewInput {
    case didTapOpenSubscriberProfile
    case didTapOpenMenu
    case didTapOpenPost
    case didTapAddPost
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
        switch viewInput {
        case .didTapOpenSubscriberProfile:
            state = .openScreenSubscriber
        case .didTapOpenMenu:
            state = .openScreenMenu
        case .didTapOpenPost:
            state = .openScreenPost
        case .didTapAddPost:
            break
        }
    }
    
}
