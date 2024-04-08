//
//  PhotoCollectionViewCell.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 7.4.24..
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "PhotoCollectionViewCellID"
    
    //MARK: Properties
    
    private lazy var pictureImage = PhotoAssembly().view()
    private var photoID: String?
    
    //MARK: Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func setupCell(photoID: String) {
        self.photoID = photoID
//        pictureImage.setupAvatar(self.photoID ?? "")
    }
    
    func getPhotoID() -> String? {
        return photoID
    }
    
    private func setupUI() {
        self.contentView.addSubview(self.pictureImage)

        NSLayoutConstraint.activate([
            self.pictureImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.pictureImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.pictureImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.pictureImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}

