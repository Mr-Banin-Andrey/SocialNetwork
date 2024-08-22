//
//  CreatePostAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 7.5.24..
//

import Foundation

final class CreatePostAssembly {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func viewController() -> CreatePostViewController {
        let viewModel = CreatePostViewModel(user: user)
        let viewController = CreatePostViewController(viewModel: viewModel)
        return viewController
    }
}
