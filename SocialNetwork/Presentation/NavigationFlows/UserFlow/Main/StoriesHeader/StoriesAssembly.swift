//
//  StoriesAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import Foundation

final class StoriesAssembly {
    
    private var followingAvatars: [String]
    
    init(followingAvatars: [String]) {
        self.followingAvatars = followingAvatars
    }
    
    func view() -> StoriesView {
        let viewModel = StoriesViewModel(followingAvatars: followingAvatars)
        let view = StoriesView(viewModel: viewModel)
        return view
    }
}
