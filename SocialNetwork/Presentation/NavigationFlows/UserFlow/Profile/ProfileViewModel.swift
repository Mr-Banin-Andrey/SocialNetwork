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
}

enum ProfileViewInput {
    case didTapAddNewPost
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
    
    var user: User
    
    var posts: [(date: Date, posts: [Post])] = []
 
    //MARK: Initial
    
    init(user: User) {
        self.user = user
        
        posts = GroupingForPosts.groupByDate(user.posts)
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {

    }
    
}
