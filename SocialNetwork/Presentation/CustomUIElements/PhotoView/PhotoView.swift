//
//  PhotoView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 31.3.24..
//

import UIKit

protocol PhotoViewDelegate: AnyObject {
    func didTapPhoto()
}

final class PhotoView: UIView {
    
    private let viewModel: PhotoViewModel
    
    weak var delegate: PhotoViewDelegate?
    
    //MARK: Properties
    
    private lazy var pictureImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.image = .forPostMockObjectImage
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoTapped))
        $0.addGestureRecognizer(tapGesture)
        return $0
    }(UIImageView())
    
    private lazy var activityIndicator = UIActivityIndicatorView().activityIndicator
    
    //MARK: Initial
    
    init(viewModel: PhotoViewModel, isEdit: Bool) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupUI()
        pictureImage.isUserInteractionEnabled = isEdit
        bindViewModel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func setupPhoto(_ photoID: String) {
        viewModel.updateState(with: .startLoadPhoto(photoID, UIImage.forGallery.jpegData(compressionQuality: 1.0) ?? Data()))
    }
    
    func updatePhoto(_ imageData: Data) {
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
                    self.pictureImage.image = .forPostMockObjectImage
                }
            }
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
    
    @objc private func photoTapped() {
        delegate?.didTapPhoto()
    }
}
