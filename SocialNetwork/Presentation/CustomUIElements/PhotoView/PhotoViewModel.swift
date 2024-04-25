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
    case startLoadPhoto(String, Data)
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
    
    @Dependency private var useCase: UserUseCase
    
    //MARK: Methods
    
    func updateState(with viewInput: ViewInput) {
        switch viewInput {
        case .startLoadPhoto(let photoID, let mockData):
            self.state = .loadPicture
            useCase.fetchImageData(imageID: photoID, basePath: .userGallery) { (result: Result<Data,Error>) in
                switch result {
                case .success(let dataImage):
                    self.state = .didLoadPicture(dataImage)
                case .failure(let error):
                    print("Error didLoadTeamAvatar ImageForCellViewModel: >>>>> \(error)")
                    self.state = .noAvatar
                    self.useCase.addImageInCache(image: mockData, imageID: photoID)
                }
            }
            self.state = .initial
        }
    }
    
}
