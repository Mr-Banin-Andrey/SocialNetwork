//
//  WholePostViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 3.4.24..
//

import Foundation

// MARK: - WholePostViewModelProtocol

protocol WholePostViewModelProtocol: ViewModelProtocol where State == WholePostState, ViewInput == WholePostViewInput {}

// MARK: - Associated enums

enum WholePostState {
    case initial
    case tryingToSendComment
    case updateView
    case failedAddComment
    case failedAddLike
}

enum WholePostViewInput {
    case sendComment(String)
    case likePost
}

// MARK: - WholePostViewModel

final class WholePostViewModel: WholePostViewModelProtocol {
    
    // MARK: State related properties
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    var post: Post
    
    @Dependency private var userUseCase: UserUseCase
    
    private let notificationCenter = NotificationCenter.default
    
    //MARK: Initial
    
    init(post: Post) {
        self.post = post
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .sendComment(let comment):
            state = .tryingToSendComment
            userUseCase.addCommentInPost(post: post, comment: comment) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let comment):
                    DispatchQueue.main.async {
                        self.post.comments.append(comment)
                        self.state = .updateView
                        self.notificationCenterPost()
                    }
                case .failure(let failure):
                    state = .failedAddComment
                    print("error addCommentInPost \(failure)")
                }
            }
        case .likePost:
            state = .tryingToSendComment
            userUseCase.addLikePost(post: post) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let likes):
                    DispatchQueue.main.async {
                        self.updateLikeField(isLike: self.post.likePost)
                        self.post.likes = likes
                        self.state = .updateView
                        self.notificationCenterPost()
                    }
                case .failure(let failure):
                    state = .failedAddComment
                    print("error addLikePost \(failure)")
                }
            }
        }
    }
    
    private func notificationCenterPost() {
        notificationCenter.post(name: NotificationKey.wholePostKey, object: nil)
    }
    
    private func updateLikeField(isLike: Bool) {
        self.post.likePost = !isLike
    }
}
