//
//  SubscriberAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 29.3.24..
//

import Foundation

final class SubscriberAssembly {
    
    func viewController() -> SubscriberViewController {
        let viewModel = SubscriberViewModel()
        let viewController = SubscriberViewController(viewModel: viewModel)
        return viewController
    }
}
