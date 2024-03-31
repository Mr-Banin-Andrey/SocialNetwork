//
//  StorieCell.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 28.3.24..
//

import UIKit

final class StorieCell: UICollectionViewCell {
    
    static let reuseID = "ImageCellID"
    
    //MARK: Properties
    
    private lazy var pictureImage = AvatarAssembly(size: .sizeSixty, isBorder: true).view()
    private var userID: String?
    
    //MARK: Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func setupCell(userID: String) {
        self.userID = userID
        pictureImage.setupAvatar(self.userID ?? "")
    }
    
    func getUserID() -> String? {
        return userID
    }
    
    private func setupUI() {
        self.contentView.addSubview(self.pictureImage)

        NSLayoutConstraint.activate([
            self.pictureImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.pictureImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.pictureImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.pictureImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
