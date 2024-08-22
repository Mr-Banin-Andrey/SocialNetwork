//
//  ChooseFromGalleryTableViewCell.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.5.24..
//

import UIKit

final class ChooseFromGalleryTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    static let reuseID = "ChooseFromGalleryTableViewCellID"
    
    private lazy var galleryImage: UIImageView = {
        $0.image = .galleryImage
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .textAndButtonColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var chooseFromGalleryLabel: UILabel = {
        $0.text = "Загрузить из Галереи"
        $0.font = .interRegular400Font.withSize(17)
        $0.textColor = .textAndButtonColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var choosePhotoHintLabel: UILabel = {
        $0.text = "Выберите фото в памяти телефона"
        $0.font = .interRegular400Font.withSize(15)
        $0.textColor = .textAndButtonColor.withAlphaComponent(0.6)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    private lazy var arrowImage: UIImageView = {
        $0.image = .chevronRightImage
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .textAndButtonColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    private func setupUI() {
        contentView.addSubview(galleryImage)
        contentView.addSubview(chooseFromGalleryLabel)
        contentView.addSubview(choosePhotoHintLabel)
        contentView.addSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            galleryImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            galleryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            galleryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            galleryImage.heightAnchor.constraint(equalToConstant: 40),
            galleryImage.widthAnchor.constraint(equalToConstant: 40),
            
            chooseFromGalleryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            chooseFromGalleryLabel.leadingAnchor.constraint(equalTo: galleryImage.trailingAnchor, constant: 10),
            
            choosePhotoHintLabel.topAnchor.constraint(equalTo: chooseFromGalleryLabel.bottomAnchor, constant: 4),
            choosePhotoHintLabel.leadingAnchor.constraint(equalTo: galleryImage.trailingAnchor, constant: 10),
            
            arrowImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}
