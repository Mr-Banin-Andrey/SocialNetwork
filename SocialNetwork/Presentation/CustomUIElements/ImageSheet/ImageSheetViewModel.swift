//
//  ImageSheetViewModel.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.5.24..
//

import Foundation

// MARK: - ImageSheetViewModelProtocol

protocol ImageSheetViewModelProtocol: ViewModelProtocol where State == ImageSheetViewModelState, ViewInput == ImageSheetViewModelViewInput {}

// MARK: - Associated enums

enum ImageSheetViewModelState {
    case initial
    case showCamera
    case showGallery
    case save
    case showAlertOnImageCompressionFailure
}

enum ImageSheetViewModelViewInput {
    case didGetImage(Data)
    case didTapOpenCamera
    case didTapOpenGallery

    case showAlertOnImageCompressionFailure
}

// MARK: - ImageSheetViewModel

final class ImageSheetViewModel: ImageSheetViewModelProtocol {
    
    enum ObjectType {
        case newPost
        case newAvatar
    }
    
    // MARK: State related properties
    
    private(set) var state: ImageSheetViewModelState = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    var onStateDidChange: ((ImageSheetViewModelState) -> Void)?
    
    // MARK: Private properties
    
    @Dependency private var useCase: UserUseCase
    
    private let objectID: String
    private let objectType: ObjectType
    
    private let notificationCenter = NotificationCenter.default
    
    // MARK: Init
    
    init(
        objectID: String,
        objectType: ObjectType
    ) {
        self.objectID = objectID
        self.objectType = objectType
    }
    
    // MARK: Methods
    
    func updateState(with viewInput: ImageSheetViewModelViewInput) {
        switch viewInput {
        case .didGetImage(let imageData):
            notificationCenterPost(type: objectType, imageData: imageData)
            state = .save
        case .didTapOpenCamera:
            state = .showCamera
        case .didTapOpenGallery:
            state = .showGallery
        case .showAlertOnImageCompressionFailure:
            state = .showAlertOnImageCompressionFailure
        }
    }
    
    private func notificationCenterPost(type: ObjectType, imageData: Data) {
        switch type {
        case .newPost:
            notificationCenter.post(name: NotificationKey.newPostKey, object: nil, userInfo: ["imageData": imageData])
        case .newAvatar:
            notificationCenter.post(name: NotificationKey.newAvatarKey, object: nil, userInfo: ["imageData": imageData])
        }
        
    }
}

