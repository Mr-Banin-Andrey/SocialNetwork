//
//  StoriesViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import Foundation

// MARK: - StoriesViewModelProtocol

protocol StoriesViewModelProtocol: ViewModelProtocol where State == StoriesState, ViewInput == StoriesViewInput {}

// MARK: - Associated enums

enum StoriesState {
    case initial
    case openScreenSubscriber
}

enum StoriesViewInput {
    case didTapAvatar
}

// MARK: - StoriesViewModel

final class StoriesViewModel: StoriesViewModelProtocol {
    
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
        case .didTapAvatar:
            state = .openScreenSubscriber
        }
    }
    
}
