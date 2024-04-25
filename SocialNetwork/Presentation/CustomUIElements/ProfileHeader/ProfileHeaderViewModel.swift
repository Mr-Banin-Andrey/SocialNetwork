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
    case showScreenGallery([AlbumCodable])
}

enum ProfileHeaderViewInput {
    case didTapOpenScreenGallery
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
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .didTapOpenScreenGallery:
            state = .showScreenGallery(user.photos)
        }
    }
    
}


