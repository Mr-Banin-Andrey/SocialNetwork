//
//  SubscriberViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 29.3.24..
//

import Foundation

// MARK: - SubscriberViewModelProtocol

protocol SubscriberViewModelProtocol: ViewModelProtocol where State == SubscriberState, ViewInput == SubscriberViewInput {}

// MARK: - Associated enums

enum SubscriberState {
    case initial
}

enum SubscriberViewInput {
    
}

// MARK: - SubscriberViewModel

final class SubscriberViewModel: SubscriberViewModelProtocol {
    
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
