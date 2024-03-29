//
//  AvatarAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import Foundation

final class AvatarAssembly {
    
    private let size: AvatarView.AvatarSize
    
    func view() -> AvatarView {
        let viewModel = AvatarViewModel()
        let view = AvatarView(viewModel: viewModel, size: size)
        return view
    }
    
    init(size: AvatarView.AvatarSize) {
        self.size = size
    }
}
