//
//  ProfileHeaderView.swift
//  SocialNetwork
//
//  Created by Андрей Банин on 30.3.24..
//

import UIKit

final class ProfileHeaderView: UIView {
    
    enum TypeView {
        case profileView
        case subscriberView
    }
    
    private let viewModel: ProfileHeaderViewModel
    
    //MARK: Properties
    
    private lazy var avatarImage = AvatarAssembly(size: .sizeEighty, isBorder: false).view()
    
    private lazy var nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Ivanka Pushkin"
        $0.textColor = .textAndButtonColor
        $0.font = .interSemiBold600Font
        return $0
    }(UILabel())
    
    private lazy var professionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Policmen"
        $0.textColor = .textSecondaryColor
        $0.font = .interRegular400Font
        return $0
    }(UILabel())
    
    private lazy var infoLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Подробная информация"
        $0.textColor = .textAndButtonColor
        $0.font = .interMedium500Font
        $0.addTrailing(image: UIImage(systemName: "exclamationmark.circle.fill") ?? UIImage())
        return $0
    }(UILabel())
    
    private var type: TypeView = .profileView {
        didSet{
            switch type {
            case .profileView:
                break
            case .subscriberView:
                break
            }
        }
    }
    
    //MARK: Initial
    
    init(viewModel: ProfileHeaderViewModel, type: TypeView) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.setupUI()
        setupImage(type: type)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                break

            }
        }
    }
    
    private func setupImage(type: TypeView) {
        switch type {
        case .profileView:
            self.type = .profileView
        case .subscriberView:
            self.type = .subscriberView
        }
    }
    
    private func setupUI() {
        addSubview(avatarImage)
        addSubview(nameLabel)
        addSubview(professionLabel)
//        addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImage.heightAnchor.constraint(equalToConstant: 80),
            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            
            ///
            avatarImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            ///
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: 16),
            
            professionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 6),
            professionLabel.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: 16),
            
            
//            infoLabel.topAnchor.constraint(equalTo: self.professionLabel.bottomAnchor, constant: 6),
//            infoLabel.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: 16),
            
            
        ])
    }
}

extension UILabel {
    func addTrailing(image: UIImage) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: self.text!, attributes: [:])

        string.append(attachmentString)
        self.attributedText = string
    }
}
