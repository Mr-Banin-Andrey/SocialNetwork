//
//  PhotoGalleryAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.4.24..
//

import Foundation

final class PhotoGalleryAssembly {
    
    private var photoGalleryType: PhotoGalleryViewController.PhotoGalleryType
    private var albums: [AlbumCodable]
    
    init(photoGalleryType: PhotoGalleryViewController.PhotoGalleryType, albums: [AlbumCodable]) {
        self.photoGalleryType = photoGalleryType
        self.albums = albums
    }
    
    func viewController() -> PhotoGalleryViewController {
        let viewModel = PhotoGalleryViewModel(albums: albums)
        let viewController = PhotoGalleryViewController(viewModel: viewModel, type: photoGalleryType)
        return viewController
    }
}
