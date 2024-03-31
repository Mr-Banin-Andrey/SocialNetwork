//
//  ProfileHeaderCollectionCell.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 30.3.24..
//

import UIKit

final class ProfileHeaderCollectionCell: UICollectionViewCell {
    
    static let reuseID = "ProfileHeaderCollectionCellID"
    
    //MARK: Properties
            
    private lazy var photoImage = PhotoAssembly().view()

    //MARK: Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    private func setupUI() {
        self.contentView.addSubview(self.photoImage)

        NSLayoutConstraint.activate([
            self.photoImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.photoImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 2),
            self.photoImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -2),
            self.photoImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.photoImage.heightAnchor.constraint(equalToConstant: 66),
            self.photoImage.widthAnchor.constraint(equalToConstant: 72)
        ])
    }
}
