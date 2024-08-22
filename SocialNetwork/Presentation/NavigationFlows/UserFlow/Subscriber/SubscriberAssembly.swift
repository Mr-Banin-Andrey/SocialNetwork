//
//  SubscriberAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 29.3.24..
//

import Foundation

final class SubscriberAssembly {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func viewController() -> SubscriberViewController {
        let viewModel = SubscriberViewModel(user: user)
        let viewController = SubscriberViewController(viewModel: viewModel)
        return viewController
    }
}
