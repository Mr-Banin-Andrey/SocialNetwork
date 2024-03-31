//
//  PhotoView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 31.3.24..
//

import UIKit

final class PhotoView: UIView {
    
    private let viewModel: PhotoViewModel
    
    //MARK: Properties
    
    private lazy var pictureImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.image = .giraffeMockObjectImage
        return $0
    }(UIImageView())
    
    private lazy var activityIndicator = UIActivityIndicatorView().activityIndicator
    
    //MARK: Initial
    
    init(viewModel: PhotoViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupUI()
        bindViewModel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func setupPhoto(_ photoID: String) {
        viewModel.updateState(with: .startLoadPhoto(photoID))
    }
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                break
            case .loadPicture:
                break
//                self.updateViewVisibility(isHidden: true)
//                self.activityIndicator.updateLoadingAnimation(isLoading: true)
            case .didLoadPicture(let imageData):
                break
//                DispatchQueue.main.async {
//                    self.activityIndicator.updateLoadingAnimation(isLoading: false)
//                    self.updateViewVisibility(isHidden: false)
//                    self.pictureImage.image = imageData.image
//                }
            case .noAvatar:
                break
//                DispatchQueue.main.async {
//                    self.activityIndicator.updateLoadingAnimation(isLoading: false)
//                    self.updateViewVisibility(isHidden: false)
//                    self.profileImageView.image = .giraffeMockObjectImage
//                }
            }
        }
    }

    private func updateViewVisibility(isHidden: Bool) {
        pictureImage.isHidden = isHidden
        activityIndicator.isHidden = !isHidden
    }
    
    private func setupUI() {
        self.addSubview(self.pictureImage)

        NSLayoutConstraint.activate([
            self.pictureImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.pictureImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.pictureImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.pictureImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
