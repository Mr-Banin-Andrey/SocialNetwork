//
//  StoriesViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import Foundation

// MARK: - StoriesViewModelProtocol

protocol StoriesViewModelProtocol: ViewModelProtocol where State == StoriesState, ViewInput == StoriesViewInput {}

// MARK: - Associated enums

enum StoriesState {
    case initial
    case openScreenSubscriber(User)
}

enum StoriesViewInput {
    case didTapAvatar(String)
}

// MARK: - StoriesViewModel

final class StoriesViewModel: StoriesViewModelProtocol {
    
    // MARK: State related properties
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    @Dependency private var useCase: UserUseCase
    
    var usersID: [String]
    
    
    //MARK: Initial
    
    init(usersID: [String]) {
        self.usersID = usersID
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .didTapAvatar(let userID):
            
            useCase.fetchUser(userID: userID) { [weak self] user in 
                DispatchQueue.main.async {
                    self?.state = .openScreenSubscriber(user)
                }
            }            
        }
    }
    
}
