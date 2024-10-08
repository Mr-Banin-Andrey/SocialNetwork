//
//  AvatarView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import UIKit

protocol AvatarViewDelegate: AnyObject {
    func didTapAvatar()
}

final class AvatarView: UIView {
    
    enum AvatarSize {
        case sizeFifteen
        case sizeThirty
        case sizeSixty
        case sizeEighty
    }
    
    private let viewModel: AvatarViewModel
    
    weak var delegate: AvatarViewDelegate?
    
    //MARK: Properties
    
    private lazy var pictureImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        $0.addGestureRecognizer(tapGesture)
        return $0
    }(UIImageView())
    
    private lazy var activityIndicator = UIActivityIndicatorView().activityIndicator
    
    private var size: AvatarSize = .sizeFifteen {
        didSet{
            switch size {
            case .sizeFifteen:
                pictureImage.layer.cornerRadius = 7.5
                pictureImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
                pictureImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
            case .sizeThirty:
                pictureImage.layer.cornerRadius = 15
                pictureImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
                pictureImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
            case .sizeSixty:
                pictureImage.layer.cornerRadius = 30
                pictureImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
                pictureImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
            case .sizeEighty:
                pictureImage.layer.cornerRadius = 40
                pictureImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
                pictureImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
            }
        }
    }
    
    //MARK: Initial
    
    init(viewModel: AvatarViewModel, size: AvatarSize, isBorder: Bool, isEdit: Bool) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupUI()
        setupType(type: size)
        setupBorder(isBorder)
        pictureImage.isUserInteractionEnabled = isEdit
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func setupAvatar(_ userID: String) {
        viewModel.updateState(with: .startLoadAvatar(userID, UIImage.logInLogoImage.jpegData(compressionQuality: 1.0) ?? Data()))
    }
    
    func updateAvatar(_ imageData: Data) {
        pictureImage.image = UIImage(data: imageData)
    }
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                break
            case .loadPicture:
                self.updateViewVisibility(isHidden: true)
                self.activityIndicator.updateLoadingAnimation(isLoading: true)
            case .didLoadPicture(let imageData):
                DispatchQueue.main.async {
                    self.activityIndicator.updateLoadingAnimation(isLoading: false)
                    self.updateViewVisibility(isHidden: false)
                    self.pictureImage.image = imageData.image
                }
            case .noAvatar:
                DispatchQueue.main.async {
                    self.activityIndicator.updateLoadingAnimation(isLoading: false)
                    self.updateViewVisibility(isHidden: false)
                    self.pictureImage.image = .logInLogoImage
                }
            }
        }
    }
    
    private func setupBorder(_ isBorder: Bool) {
        if isBorder {
            pictureImage.layer.borderWidth = 1
            pictureImage.layer.borderColor = UIColor.textTertiaryColor.cgColor
        }
    }
    
    private func setupType(type: AvatarSize) {
        switch type {
        case .sizeFifteen:
            self.size = .sizeFifteen
        case .sizeThirty:
            self.size = .sizeThirty
        case .sizeSixty:
            self.size = .sizeSixty
        case .sizeEighty:
            self.size = .sizeEighty
        }
    }
    
    private func updateViewVisibility(isHidden: Bool) {
        pictureImage.isHidden = isHidden
        activityIndicator.isHidden = !isHidden
    }
    
    private func setupUI() {
        self.addSubview(self.activityIndicator)
        self.addSubview(self.pictureImage)
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.pictureImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.pictureImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.pictureImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.pictureImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    @objc private func avatarTapped() {
        delegate?.didTapAvatar()
    }
}
