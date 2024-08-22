//
//  MakePhotoTableViewCell.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 6.5.24..
//

import UIKit

final class MakePhotoTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    static let reuseID = "MakePhotoTableViewCellID"
    
    private lazy var cameraImage: UIImageView = {
        $0.image = .cameraImage
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .textAndButtonColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var makePhotoLabel: UILabel = {
        $0.text = "Сделать фото"
        $0.font = .interRegular400Font.withSize(17)
        $0.textColor = .textAndButtonColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var useCameraHintLabel: UILabel = {
        $0.text = "Используйте камеру телефона"
        $0.font = .interRegular400Font.withSize(15)
        $0.textColor = .textAndButtonColor.withAlphaComponent(0.6)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var arrowImage: UIImageView = {
        $0.image = .chevronRightImage
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .textAndButtonColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var separatorLine = UIView().lineView
     
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
        contentView.addSubview(cameraImage)
        contentView.addSubview(makePhotoLabel)
        contentView.addSubview(useCameraHintLabel)
        contentView.addSubview(arrowImage)
        contentView.addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            cameraImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cameraImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            cameraImage.heightAnchor.constraint(equalToConstant: 40),
            cameraImage.widthAnchor.constraint(equalToConstant: 40),
            
            makePhotoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            makePhotoLabel.leadingAnchor.constraint(equalTo: cameraImage.trailingAnchor, constant: 10),
            
            useCameraHintLabel.topAnchor.constraint(equalTo: makePhotoLabel.bottomAnchor, constant: 4),
            useCameraHintLabel.leadingAnchor.constraint(equalTo: cameraImage.trailingAnchor, constant: 10),
            
            arrowImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            separatorLine.topAnchor.constraint(equalTo: cameraImage.bottomAnchor, constant: 12),
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }
}
