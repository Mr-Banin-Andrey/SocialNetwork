//
//  EditPersonalDataViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.5.24..
//

import Foundation

// MARK: - EditPersonalDataViewModelProtocol

protocol EditPersonalDataViewModelProtocol: ViewModelProtocol where State == EditPersonalDataState, ViewInput == EditPersonalDataViewInput {}

// MARK: - Associated enums

enum EditPersonalDataState {
    case initial
    case tryingToSignUp
    case savedChange
    case showAlertErrorSave
    case showAvatarSheet(String)
}

enum EditPersonalDataViewInput {
    case didTapSaveChanges(User, Data)
    case didTapAvatar
}

// MARK: - EditPersonalDataViewModel

final class EditPersonalDataViewModel: EditPersonalDataViewModelProtocol {
    
    // MARK: State related properties
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    @Dependency private var useCase: UserUseCase
    
    private let notificationCenter = NotificationCenter.default
    
    var user: User
    
    //MARK: Initial
    
    init(user: User) {
        self.user = user
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .didTapSaveChanges(let user, let imageData):
            
            state = .tryingToSignUp
            useCase.updateProfileData(imageData: imageData, user: user) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.state = .savedChange
                        self.notificationCenterPost()
                    }
                case .failure(let failure):
                    state = .showAlertErrorSave
                    print("Error showAlertErrorSave .. \(failure)")
                }
                self.state = .initial
            }
        case .didTapAvatar:
            state = .showAvatarSheet(user.id)
        }
    }
    
    private func notificationCenterPost() {
        notificationCenter.post(name: NotificationKey.editPersonalDataKey, object: nil)
    }
    
}
