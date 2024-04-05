//
//  WholePostAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 3.4.24..
//

import Foundation

final class WholePostAssembly {
    
    func viewController() -> WholePostViewController {
        let viewModel = WholePostViewModel()
        let viewController = WholePostViewController(viewModel: viewModel)
        return viewController
    }
}
