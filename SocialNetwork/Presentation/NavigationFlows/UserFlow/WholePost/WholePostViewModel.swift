//
//  WholePostViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 3.4.24..
//

import Foundation

// MARK: - WholePostViewModelProtocol

protocol WholePostViewModelProtocol: ViewModelProtocol where State == WholePostState, ViewInput == WholePostViewInput {}

// MARK: - Associated enums

enum WholePostState {
    case initial
}

enum WholePostViewInput {
    
}

// MARK: - WholePostViewModel

final class WholePostViewModel: WholePostViewModelProtocol {
    
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
