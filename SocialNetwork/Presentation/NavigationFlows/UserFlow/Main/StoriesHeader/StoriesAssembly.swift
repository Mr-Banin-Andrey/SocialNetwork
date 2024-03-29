//
//  StoriesAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import Foundation

final class StoriesAssembly {
    
    func view() -> StoriesView {
        let viewModel = StoriesViewModel()
        let view = StoriesView(viewModel: viewModel)
        return view
    }
}
