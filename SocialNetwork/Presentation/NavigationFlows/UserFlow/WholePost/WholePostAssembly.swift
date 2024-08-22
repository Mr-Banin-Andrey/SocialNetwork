//
//  WholePostAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 3.4.24..
//

import Foundation

final class WholePostAssembly {
    
    private let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func viewController() -> WholePostViewController {
        let viewModel = WholePostViewModel(post: post)
        let viewController = WholePostViewController(viewModel: viewModel)
        return viewController
    }
}
