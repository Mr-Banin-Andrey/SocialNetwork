//
//  PhotoAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 31.3.24..
//

import Foundation

final class PhotoAssembly {
        
    func view() -> PhotoView {
        let viewModel = PhotoViewModel()
        let view = PhotoView(viewModel: viewModel)
        return view
    }

}
