//
//  AvatarViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import Foundation

// MARK: - AvatarViewModelProtocol

protocol AvatarViewModelProtocol: ViewModelProtocol where State == AvatarState, ViewInput == AvatarViewInput {}

// MARK: - Associated enums

enum AvatarState {
    case initial
    case loadPicture
    case didLoadPicture(Data)
    case noAvatar
}

enum AvatarViewInput {
    case startLoadAvatar(String)
}

// MARK: - AvatarViewModel

final class AvatarViewModel: AvatarViewModelProtocol {
    
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
