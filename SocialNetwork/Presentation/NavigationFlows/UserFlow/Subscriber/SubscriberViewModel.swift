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
    case openScreenMenu(Post)
    case openScreenPost(Post)
    case openScreenGallery([AlbumCodable])
}

enum SubscriberViewInput {
    case didTapOpenMenu(Post)
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
    
    var subscriber: User
    
    var posts: [(date: Date, posts: [Post])] = [] 
    
    //MARK: Initial
    
    init(user: User) {
        self.subscriber = user
        
        posts = GroupingForPosts.groupByDate(user.posts)
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .didTapOpenMenu(let post):
            state = .openScreenMenu(post)
        case .didTapOpenPost(let post):
            state = .openScreenPost(post)
        case .didTapOpenGallery(let albums):
            state = .openScreenGallery(albums)
        }
    }
    
}
