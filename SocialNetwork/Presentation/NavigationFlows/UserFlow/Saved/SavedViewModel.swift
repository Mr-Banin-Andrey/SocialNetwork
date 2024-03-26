//
//  SavedViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 17.3.24..
//

import Foundation

// MARK: - SavedViewModelProtocol

protocol SavedViewModelProtocol: ViewModelProtocol where State == SavedState, ViewInput == SavedViewInput {}

// MARK: - Associated enums

enum SavedState {
    case initial
}

enum SavedViewInput {
    
}

// MARK: - SavedViewModel

final class SavedViewModel: SavedViewModelProtocol {
    
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
