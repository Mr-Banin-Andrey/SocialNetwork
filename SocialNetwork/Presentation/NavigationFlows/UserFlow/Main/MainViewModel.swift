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
    case openScreenMenu(Post)
    case openScreenPost(Post)
    case showPostsForUser
    case showAllPosts
}

enum MainViewInput {
    case startLoadPosts
    case didTapOpenSubscriberProfile(String)
    case didTapOpenMenu(Post)
    case didTapOpenPost(Post)
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
    
    var user: User?
    var posts: [(date: Date, posts: [Post])] = []
    var usersID: [String] = []
    
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
            
        case .startLoadPosts:
            
            user = useCase.user
            
            useCase.fetchPosts() { [weak self] allPostsFromDataBase in
                guard let self else { return }
                                
                self.allPosts = allPostsFromDataBase.sorted(by: { $0.dateCreated < $1.dateCreated })
                let users = Set(allPostsFromDataBase.map { $0.userCreatedID })
                usersID = Array(users)
                
                var forUser: [Post] = []
                guard let user = user else {return}
                for postID in user.following {
                    let posts = allPostsFromDataBase.filter { $0.userCreatedID == postID }
                    forUser += posts
                }
                
                self.postsForUser = forUser.sorted(by: { $0.dateCreated < $1.dateCreated })
                
                DispatchQueue.main.async {
                    self.posts = GroupingForPosts.groupByDate(self.allPosts)
                    self.state = .showAllPosts
                }
            }

        case .didTapOpenSubscriberProfile(let userID):
            guard let user = user else {return}
            if userID != user.id {
                let posts = allPosts.filter { $0.userCreatedID == userID}
                useCase.fetchUser(userID: userID, posts: posts) { [weak self] user in
                    DispatchQueue.main.async {
                        self?.state = .openScreenSubscriber(user)
                    }
                }
            }
            
        case .didTapOpenMenu(let post):
            state = .openScreenMenu(post)
        case .didTapOpenPost(let post):
            state = .openScreenPost(post)
        case .didTapAllPosts:
            posts = GroupingForPosts.groupByDate(self.allPosts)
            state = .showAllPosts

        case .didTapPostsForUser:
            posts = GroupingForPosts.groupByDate(self.postsForUser)
            state = .showPostsForUser
        }
    }
}
