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
    case showPostsForUser
    case showAllPosts
}

enum MainViewInput {
    case didTapOpenSubscriberProfile
    case didTapOpenMenu
    case didTapOpenPost
    case didTapAddPostToSaved
    case didTapPostsForUser
    case didTapAllPosts
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
        case .didTapAddPostToSaved:
            break
        case .didTapAllPosts:
            state = .showAllPosts
        case .didTapPostsForUser:
            state = .showPostsForUser
        }
    }
    
}
