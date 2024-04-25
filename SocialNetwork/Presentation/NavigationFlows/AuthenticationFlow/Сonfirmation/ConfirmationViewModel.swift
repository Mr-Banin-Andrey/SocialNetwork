//
//  ConfirmationViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 9.1.24..
//

import Foundation
import FirebaseAuth

// MARK: - ConfirmationViewModelProtocol

protocol ConfirmationViewModelProtocol: ViewModelProtocol where State == ConfirmationState, ViewInput == ConfirmationViewInput {}

// MARK: - Associated enums

enum ConfirmationState {
    case initial
    case tryingToSignIn
    case showUser(User)
}

enum ConfirmationViewInput {
    case registrationOnSocialNetwork(String)
}

// MARK: - Associated enums

final class ConfirmationViewModel: ConfirmationViewModelProtocol {
    
    // MARK: State related properties
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    @Dependency private var authenticationUseCase: AuthenticationUseCase
    
    var phone: String
    
    //MARK: Initial
    
    init(phone: String) {
        self.phone = phone
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .registrationOnSocialNetwork(let verificationCode):
            
            authenticationUseCase.registrationLogInToAccount(code: verificationCode) { [weak self] result in
                switch result {
                case .success(let userID):
                    
                    print("userID - ", userID)
                    self?.authenticationUseCase.fetchUser(userID: userID, completion: { [weak self] result in
                        switch result {
                        case .success(let user):
                            DispatchQueue.main.async {
                                self?.state = .showUser(user)
                            }
                        case .failure(let failure):
                            if FirestoreService.FirestoreServiceError.notFoundUser == failure {
                                self?.authenticationUseCase.addNewUser(userID: userID, completion: { [weak self] result in
                                    switch result {
                                    case .success(let user):
                                        DispatchQueue.main.async {
                                            self?.state = .showUser(user)
                                        }
                                    case .failure(let failure):
                                        print("Error addNewUser: ... \(failure)")
                                    }
                                })
                            }
                        }
                    })
                    
                case .failure(let failure):
                    print("Error registrationLogInToAccount: ... \(failure)")
                }
            }
        }
    }
    
}
