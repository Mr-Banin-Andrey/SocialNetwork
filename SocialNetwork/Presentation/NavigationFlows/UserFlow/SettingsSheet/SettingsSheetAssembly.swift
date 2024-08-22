//
//  SettingsSheetAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 12.4.24..
//

import Foundation

final class SettingsSheetAssembly {
    
    private var post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func viewController() -> SettingsSheetViewController {
        let viewModel = SettingsSheetViewModel(post: post)
        let viewController = SettingsSheetViewController(viewModel: viewModel)
        return viewController
    }
}
