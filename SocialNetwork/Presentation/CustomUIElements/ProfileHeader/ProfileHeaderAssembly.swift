//
//  ProfileHeaderAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 30.3.24..
//

import Foundation

final class ProfileHeaderAssembly {
    
    private let type: ProfileHeaderView.TypeView
    
    init(type: ProfileHeaderView.TypeView) {
        self.type = type
    }
    
    func view() -> ProfileHeaderView {
        let viewModel = ProfileHeaderViewModel()
        let view = ProfileHeaderView(viewModel: viewModel, type: type)
        return view
    }
}
