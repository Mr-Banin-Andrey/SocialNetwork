//
//  ForgotPasswordViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.5.24..
//

import Foundation


// MARK: - ForgotPasswordViewModelProtocol

protocol ForgotPasswordViewModelProtocol: ViewModelProtocol where State == ForgotPasswordState, ViewInput == ForgotPasswordViewInput {}

// MARK: - Associated enums

enum ForgotPasswordState {
    case initial
    case showAlertSuccess
    case showAlertFailed
}

enum ForgotPasswordViewInput {
    case didTapPasswordRecovery(String)
}

// MARK: - Associated enums

final class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {

    // MARK: State related properties

    var onStateDidChange: ((State) -> Void)?

    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }

    @Dependency private var authenticationUseCase: AuthenticationUseCase

    //MARK: Methods

    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .didTapPasswordRecovery(let email):
            authenticationUseCase.forgotPassword(email: email) { [weak self] result in
                switch result {
                case .success():
                    self?.state = .showAlertSuccess
                case .failure(let failure):
                    self?.state = .showAlertFailed
                    print("Error PasswordRecovery \(failure)")
                }
            }
        }
    }

}
