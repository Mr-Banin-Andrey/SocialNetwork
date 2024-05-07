//
//  ProfileViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 17.3.24..
//

import Foundation

// MARK: - ProfileViewModelProtocol

protocol ProfileViewModelProtocol: ViewModelProtocol where State == ProfileState, ViewInput == ProfileViewInput {}

// MARK: - Associated enums

enum ProfileState {
    case initial
    case updateView
    case openScreenMenu(Post)
    case openScreenPost(Post)
    case openScreenGallery([AlbumCodable])
    case showAlertExit
    case logOut
}

enum ProfileViewInput {
    case willStartUpdate
    case didTapAddNewPost
    case didTapOpenMenu(Post)
    case didTapOpenPost(Post)
    case didTapOpenGallery([AlbumCodable])
    case didTapExitButton
    case logOutButton
}

// MARK: - ProfileViewModel

final class ProfileViewModel: ProfileViewModelProtocol {
    
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
            posts = GroupingForPosts.groupByDate(user.posts)
            state = .updateView
        case .didTapAddNewPost:
            break
        case .didTapOpenMenu(let post):
            state = .openScreenMenu(post)
        case .didTapOpenPost(let post):
            state = .openScreenPost(post)
        case .didTapOpenGallery(let albums):
            state = .openScreenGallery(albums)
        case .didTapExitButton:
            state = .showAlertExit
        case .logOutButton:
            useCase.signOut()
            state = .logOut
            
        }
    }
    
}
