//
//  ProfileHeaderViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 30.3.24..
//

import Foundation

// MARK: - ProfileHeaderViewModelProtocol

protocol ProfileHeaderViewModelProtocol: ViewModelProtocol where State == ProfileHeaderState, ViewInput == ProfileHeaderViewInput {}

// MARK: - Associated enums

enum ProfileHeaderState {
    case initial
    
}

enum ProfileHeaderViewInput {
}

// MARK: - ProfileHeaderViewModel

final class ProfileHeaderViewModel: ProfileHeaderViewModelProtocol {
    
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


