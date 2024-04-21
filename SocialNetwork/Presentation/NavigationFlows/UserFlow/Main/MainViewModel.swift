//
//  MainViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 14.3.24..
//

import Foundation
import UIKit

// MARK: - MainViewModelProtocol

protocol MainViewModelProtocol: ViewModelProtocol where State == MainState, ViewInput == MainViewInput {}

// MARK: - Associated enums

enum MainState {
    case initial
    case openScreenSubscriber(User)
    case openScreenMenu
    case openScreenPost
    case showPostsForUser
    case showAllPosts
}

enum MainViewInput {
    case startLoadPosts
    case didTapOpenSubscriberProfile(String)
    case didTapOpenMenu
    case didTapOpenPost
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
    
    @Dependency private var useCase: UserUseCase
    private var allPosts: [Post] = []
    private var postsForUser: [Post] = []
    
    var user: User
    var posts: [(date: Date, posts: [Post])] = []

    //MARK: Initial
    
    init(user: User) {
        self.user = user
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
            
        case .startLoadPosts:
            useCase.fetchPosts(following: user.following) { [weak self] allPosts, postsForUser in
                guard let self else { return }
                self.allPosts = allPosts.sorted(by: { $0.dateCreated < $1.dateCreated })
                self.postsForUser = postsForUser.sorted(by: { $0.dateCreated < $1.dateCreated })
                
                DispatchQueue.main.async {
                    self.posts = GroupingForPosts.groupByDate(self.allPosts)
                    self.state = .showAllPosts
                }
            }
            
        case .didTapOpenSubscriberProfile(let userID):

            if userID != user.id {
                let posts = allPosts.filter { $0.userCreatedID == userID}
                
                useCase.fetchUser(userID: userID, posts: posts) { [weak self] user in
                    DispatchQueue.main.async {
                        self?.state = .openScreenSubscriber(user)
                    }
                }
            }
            
        case .didTapOpenMenu:
            state = .openScreenMenu
        case .didTapOpenPost:
            state = .openScreenPost
        case .didTapAllPosts:
            posts = GroupingForPosts.groupByDate(self.allPosts)
            state = .showAllPosts

        case .didTapPostsForUser:
            posts = GroupingForPosts.groupByDate(self.postsForUser)
            state = .showPostsForUser
        }
    }
}
