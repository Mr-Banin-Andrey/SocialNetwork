//
//  GalleryHeaderAssembly.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 7.4.24..
//

import Foundation

final class GalleryHeaderAssembly {
    
    private let galleryType: GalleryHeaderView.GalleryHeaderType
    private var albums: [AlbumCodable]
    
    
    init(galleryType: GalleryHeaderView.GalleryHeaderType, albums: [AlbumCodable]) {
        self.galleryType = galleryType
        self.albums = albums
    }
    
    func view() -> GalleryHeaderView {
        let viewModel = GalleryHeaderViewModel(albums: albums)
        let view = GalleryHeaderView(viewModel: viewModel, galleryType: galleryType)
        return view
    }
}
