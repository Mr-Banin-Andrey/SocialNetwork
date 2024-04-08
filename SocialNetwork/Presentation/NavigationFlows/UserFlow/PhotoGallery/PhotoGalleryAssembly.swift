//
//  PhotoGalleryAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.4.24..
//

import Foundation

final class PhotoGalleryAssembly {
    
    private var photoGalleryType: PhotoGalleryViewController.PhotoGalleryType
    
    init(photoGalleryType: PhotoGalleryViewController.PhotoGalleryType) {
        self.photoGalleryType = photoGalleryType
    }
    
    func viewController() -> PhotoGalleryViewController {
        let viewModel = PhotoGalleryViewModel()
        let viewController = PhotoGalleryViewController(viewModel: viewModel, type: photoGalleryType)
        return viewController
    }
}
