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
    case updateView
    case openScreenMenu(Post)
    case openScreenPost(Post)
}

enum SavedViewInput {
    case willStartUpdate
    case didTapOpenMenu(Post)
    case didTapOpenPost(Post)
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
    
    @Dependency private var useCase: UserUseCase
    
    var user: User?
    
    var posts: [(date: Date, posts: [Post])] = []
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .willStartUpdate:
            user = useCase.user
            guard let user = user else {return}
            posts = GroupingForPosts.groupByDate(user.savedPosts)
            state = .updateView
        case .didTapOpenMenu(let post):
            state = .openScreenMenu(post)
        case .didTapOpenPost(let post):
            state = .openScreenPost(post)
        }
    }
    
}
