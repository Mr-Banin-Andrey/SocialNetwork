//
//  PhotoGalleryViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 5.4.24..
//

import Foundation

// MARK: - PhotoGalleryViewModelProtocol

protocol PhotoGalleryViewModelProtocol: ViewModelProtocol where State == PhotoGalleryState, ViewInput == PhotoGalleryViewInput {}

// MARK: - Associated enums

enum PhotoGalleryState {
    case initial
}

enum PhotoGalleryViewInput {
    
}

// MARK: - PhotoGalleryViewModel

final class PhotoGalleryViewModel: PhotoGalleryViewModelProtocol {
    
    // MARK: State related properties
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {

    }
    
}
