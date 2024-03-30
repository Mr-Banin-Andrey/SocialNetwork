//
//  ProfileHeaderAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 30.3.24..
//

import Foundation

final class ProfileHeaderAssembly {
    
    private let type: ProfileHeaderView.TypeView
    
    func view() -> ProfileHeaderView {
        let viewModel = ProfileHeaderViewModel()
        let view = ProfileHeaderView(viewModel: viewModel, type: .profileView)
        return view
    }
    
    init(type: ProfileHeaderView.TypeView) {
        self.type = type
    }
}
