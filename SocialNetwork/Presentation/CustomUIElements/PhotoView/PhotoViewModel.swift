//
//  PhotoViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 31.3.24..
//

import Foundation

// MARK: - PhotoViewModelProtocol

protocol PhotoViewModelProtocol: ViewModelProtocol where State == PhotoState, ViewInput == PhotoViewInput {}

// MARK: - Associated enums

enum PhotoState {
    case initial
    case loadPicture
    case didLoadPicture(Data)
    case noAvatar
}

enum PhotoViewInput {
    case startLoadPhoto(String)
}

// MARK: - PhotoViewModel

final class PhotoViewModel: PhotoViewModelProtocol {
    
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
