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
    case updateSubscribe(Bool)
    case showScreenGallery([AlbumCodable])
    
}

enum ProfileHeaderViewInput {
    case willLoadData
    case didTapOpenScreenGallery
    case didTapToSubscribe
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
    
    @Dependency private var useCase: UserUseCase
    
    //MARK: Initial
    
    init(user: User) {
        self.user = user
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .willLoadData:
            if useCase.user.id != user.id {
                let isSubscriber = useCase.updateStateSubscriber(userCreatedID: user.id)
                state = .updateSubscribe(isSubscriber)
            }
        case .didTapOpenScreenGallery:
            state = .showScreenGallery(user.photos)
        case .didTapToSubscribe:
            break
        }
    }
}


