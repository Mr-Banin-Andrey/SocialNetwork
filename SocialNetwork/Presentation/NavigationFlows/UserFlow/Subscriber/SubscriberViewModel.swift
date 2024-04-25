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
    case openScreenMenu
    case openScreenPost(Post)
    case openScreenGallery([AlbumCodable])
}

enum SubscriberViewInput {
    case didTapOpenMenu
    case didTapOpenPost(Post)
    case didTapOpenGallery([AlbumCodable])
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
    
    var user: User
    
    var posts: [(date: Date, posts: [Post])] = [] 
    
    //MARK: Initial
    
    init(user: User) {
        self.user = user
        
        posts = GroupingForPosts.groupByDate(user.posts)
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .didTapOpenMenu:
            state = .openScreenMenu
        case .didTapOpenPost(let post):
            state = .openScreenPost(post)
        case .didTapOpenGallery(let albums):
            state = .openScreenGallery(albums)
        }
    }
    
}
