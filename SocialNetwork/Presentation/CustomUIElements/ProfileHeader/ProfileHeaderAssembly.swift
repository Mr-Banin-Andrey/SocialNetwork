//
//  ProfileHeaderAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 30.3.24..
//

import Foundation

final class ProfileHeaderAssembly {
    
    private let type: ProfileHeaderView.TypeView
    private let user: User
    
    init(type: ProfileHeaderView.TypeView, user: User) {
        self.type = type
        self.user = user
    }
    
    func view() -> ProfileHeaderView {
        let viewModel = ProfileHeaderViewModel(user: user)
        let view = ProfileHeaderView(viewModel: viewModel, type: type)
        return view
    }
}
