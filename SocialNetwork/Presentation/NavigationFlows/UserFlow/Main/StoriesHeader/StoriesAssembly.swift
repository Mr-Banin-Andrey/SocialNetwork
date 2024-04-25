//
//  StoriesAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import Foundation

final class StoriesAssembly {
    
    private var usersID: [String]
    
    init(usersID: [String]) {
        self.usersID = usersID
    }
    
    func view() -> StoriesView {
        let viewModel = StoriesViewModel(usersID: usersID)
        let view = StoriesView(viewModel: viewModel)
        return view
    }
}
