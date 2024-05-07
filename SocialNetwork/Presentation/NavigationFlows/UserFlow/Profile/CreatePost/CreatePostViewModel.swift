//
//  CreatePostViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 7.5.24..
//

import Foundation

// MARK: - CreatePostViewModelProtocol

protocol CreatePostViewModelProtocol: ViewModelProtocol where State == CreatePostState, ViewInput == CreatePostViewInput {}

// MARK: - Associated enums

enum CreatePostState {
    case initial
    case tryingToSignUp
    case savedChange
    case showAlertErrorSave
    case showAvatarSheet(String)
}

enum CreatePostViewInput {
    case didTapSavePost(Post, Data)
    case didTapAddPhoto
}

// MARK: - CreatePostViewModel

final class CreatePostViewModel: CreatePostViewModelProtocol {
    
    // MARK: State related properties
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    @Dependency private var useCase: UserUseCase
    
    private let notificationCenter = NotificationCenter.default
    
    var postID: String = UUID().uuidString
    
    var user: User
    
    //MARK: Initial
    
    init(user: User) {
        self.user = user
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .didTapSavePost(let post, let imageData):
            
            state = .tryingToSignUp
            useCase.createPost(newPost: post, newPhoto: imageData) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success:
                    self.state = .savedChange
                    self.notificationCenterPost()
                case .failure(let failure):
                    state = .showAlertErrorSave
                    print("Error showAlertErrorSave .. \(failure)")
                }
                self.state = .initial
            }
        case .didTapAddPhoto:
            state = .showAvatarSheet(postID)
        }
    }
    
    private func notificationCenterPost() {
        notificationCenter.post(name: NotificationKey.newPostKey, object: nil)
    }
    
}
