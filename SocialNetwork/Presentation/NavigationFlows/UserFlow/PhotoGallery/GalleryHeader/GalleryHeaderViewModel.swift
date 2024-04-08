//
//  GalleryHeaderViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 7.4.24..
//

import Foundation

// MARK: - GalleryHeaderViewModelProtocol

protocol GalleryHeaderViewModelProtocol: ViewModelProtocol where State == GalleryHeaderState, ViewInput == GalleryHeaderViewInput {}

// MARK: - Associated enums

enum GalleryHeaderState {
    case initial
}

enum GalleryHeaderViewInput {
    
}

// MARK: - GalleryHeaderViewModel

final class GalleryHeaderViewModel: GalleryHeaderViewModelProtocol {
    
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
