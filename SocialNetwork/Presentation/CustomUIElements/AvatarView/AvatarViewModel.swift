//
//  AvatarViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import Foundation

// MARK: - AvatarViewModelProtocol

protocol AvatarViewModelProtocol: ViewModelProtocol where State == AvatarState, ViewInput == AvatarViewInput {}

// MARK: - Associated enums

enum AvatarState {
    case initial
    case loadPicture
    case didLoadPicture(Data)
    case noAvatar
}

enum AvatarViewInput {
    case startLoadAvatar(String, Data)
}

// MARK: - AvatarViewModel

final class AvatarViewModel: AvatarViewModelProtocol {
    
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
        case .startLoadAvatar(let userID, let mockData):
            self.state = .loadPicture
            useCase.fetchImageData(imageID: userID, basePath: .userAvatars) { (result: Result<Data,Error>) in
                switch result {
                case .success(let dataImage):
                    self.state = .didLoadPicture(dataImage)
                case .failure(let error):
                    print("Error didLoadTeamAvatar ImageForCellViewModel: >>>>> \(error)")
                    self.state = .noAvatar
                    self.useCase.addImageInCache(image: mockData, imageID: userID)
                }
            }
            self.state = .initial
        }
        
       
    }
    
}
