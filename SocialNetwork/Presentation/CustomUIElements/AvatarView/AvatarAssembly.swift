//
//  AvatarAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import Foundation

final class AvatarAssembly {
    
    private let size: AvatarView.AvatarSize
    private let isBorder: Bool
    
    init(size: AvatarView.AvatarSize, isBorder: Bool) {
        self.size = size
        self.isBorder = isBorder
    }
    
    func view() -> AvatarView {
        let viewModel = AvatarViewModel()
        let view = AvatarView(viewModel: viewModel, size: size, isBorder: isBorder)
        return view
    }
}
