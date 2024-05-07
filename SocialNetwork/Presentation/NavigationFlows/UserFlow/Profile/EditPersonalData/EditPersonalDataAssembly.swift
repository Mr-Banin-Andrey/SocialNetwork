//
//  EditPersonalDataAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.5.24..
//

import Foundation

final class EditPersonalDataAssembly {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func viewController() -> EditPersonalDataViewController {
        let viewModel = EditPersonalDataViewModel(user: user)
        let viewController = EditPersonalDataViewController(viewModel: viewModel)
        return viewController
    }
}
