//
//  SettingsSheetViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 12.4.24..
//

import Foundation

// MARK: - SettingsSheetViewModelProtocol

protocol SettingsSheetViewModelProtocol: ViewModelProtocol where State == SettingsSheetState, ViewInput == SettingsSheetViewInput {}

// MARK: - Associated enums

enum SettingsSheetState {
    case initial
    case tryingToUpdateView
    case updateView(Bool)
//    case updateStateButton(Bool)
    case showAlertFailedToAddBookmark
    case showAlertFailedToSubscriber
}

enum SettingsSheetViewInput {
    case willUpdateState
    case didTapCancelSubscription
    case didTapAddToBookmarks
}

// MARK: - SettingsSheetViewModel

final class SettingsSheetViewModel: SettingsSheetViewModelProtocol {
    
    // MARK: State related properties
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    @Dependency private var userUseCase: UserUseCase
    
    var post: Post
    
    private let notificationCenter = NotificationCenter.default
    
    //MARK: Post
    
    init(post: Post) {
        self.post = post
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .willUpdateState:
            let isFriend = userUseCase.updateStateSubscriber(userCreatedID: post.userCreatedID)
            state = .updateView(isFriend)
        case .didTapCancelSubscription:
            
            state = .tryingToUpdateView
            userUseCase.toSubscribe(subscriberID: post.userCreatedID) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(_):
                    let isFriend = userUseCase.updateStateSubscriber(userCreatedID: post.userCreatedID)
                    state = .updateView(isFriend)
                    notificationCenterPost()
                case .failure(let failure):
                    print("error didTapCancelSubscription\(failure)")
                    state = .showAlertFailedToSubscriber
                }
            }
            
        case .didTapAddToBookmarks:
            
            state = .tryingToUpdateView
            userUseCase.addBookmark(post: post) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(_):
                    let isFriend = userUseCase.updateStateSubscriber(userCreatedID: post.userCreatedID)
                    state = .updateView(isFriend)
                    notificationCenterPost()
                case .failure(let failure):
                    print("error didTapAddToBookmarks\(failure)")
                    state = .showAlertFailedToAddBookmark
                }
            }
        }
    }
    
    private func notificationCenterPost() {
        notificationCenter.post(name: NotificationKey.settingsSheetKey, object: nil)
    }
}
