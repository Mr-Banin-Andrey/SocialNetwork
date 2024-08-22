//
//  PhotoAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 31.3.24..
//

import Foundation

final class PhotoAssembly {
    
    private let isEdit: Bool
    
    init(isEdit: Bool) {
        self.isEdit = isEdit
    }
    
    func view() -> PhotoView {
        let viewModel = PhotoViewModel()
        let view = PhotoView(viewModel: viewModel, isEdit: isEdit)
        return view
    }

}
